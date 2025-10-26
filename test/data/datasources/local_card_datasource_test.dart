/// 🔶 Data Source Tests: LocalCardDataSource
///
/// Tests for local data storage operations (CRUD, search).
/// Critical for offline-first architecture - wrong storage = data loss.
///
/// Similar to Angular's LocalStorageService tests.
///
/// In Angular, you'd have:
/// ```typescript
/// describe('LocalStorageService', () => {
///   it('should save and retrieve data', () => {
///     service.setItem('key', 'value');
///     expect(service.getItem('key')).toBe('value');
///   });
/// });
/// ```

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/data/datasources/local_card_datasource.dart';
import 'package:card_snap_ui/data/models/card_model.dart';

void main() {
  group('LocalCardDataSource Tests', () {
    late LocalCardDataSource dataSource;

    setUp(() async {
      // 🔹 Setup fresh data source before each test
      // Similar to Angular's beforeEach with fresh state
      dataSource = LocalCardDataSource();
      await dataSource.initialize();
    });

    tearDown(() async {
      // 🔹 Cleanup after each test
      await dataSource.close();
    });

    group('Initialization', () {
      test('should initialize successfully', () async {
        expect(dataSource, isNotNull);
        await dataSource.initialize();
        // Should not throw
      });

      test('should handle double initialization', () async {
        await dataSource.initialize();
        await dataSource.initialize(); // Should be idempotent
        // Should not throw
      });
    });

    group('CRUD Operations', () {
      test('should save and retrieve card', () async {
        // 🔹 Core CRUD operation - critical for data persistence
        final card = createTestCardModel();
        await dataSource.saveCard(card);

        final result = await dataSource.getCardById(card.id);
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNotNull);
        expect(result.dataOrNull!.id, card.id);
      });

      test('should return empty list when no cards exist', () async {
        final result = await dataSource.getAllCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });

      test('should save multiple cards', () async {
        final card1 = createTestCardModel(id: 'card1');
        final card2 = createTestCardModel(id: 'card2');

        await dataSource.saveCard(card1);
        await dataSource.saveCard(card2);

        final result = await dataSource.getAllCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
      });

      test('should update existing card', () async {
        final card = createTestCardModel();
        await dataSource.saveCard(card);

        final updatedCard = card.copyWith(name: 'Updated Name');
        await dataSource.saveCard(updatedCard);

        final result = await dataSource.getCardById(card.id);
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.name, 'Updated Name');
        expect(result.dataOrNull!.id, card.id); // ID unchanged
      });

      test('should return null for non-existent card', () async {
        final result = await dataSource.getCardById('non_existent');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNull);
      });
    });

    group('Search Operations', () {
      setUp(() async {
        // Create test data
        await dataSource.saveCard(
          createTestCardModel(
            id: '1',
            name: 'Coffee Shop',
            storeName: 'Coffee',
          ),
        );
        await dataSource.saveCard(
          createTestCardModel(
            id: '2',
            name: 'Restaurant',
            storeName: 'Restaurant',
          ),
        );
        await dataSource.saveCard(
          createTestCardModel(
            id: '3',
            name: 'Coffee House',
            storeName: 'Coffee',
          ),
        );
      });

      test('should search cards by name', () async {
        final result = await dataSource.searchCards('Coffee');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
        expect(
          result.dataOrNull!.every((c) => c.name.contains('Coffee')),
          isTrue,
        );
      });

      test('should search cards by store name', () async {
        final result = await dataSource.searchCards('Restaurant');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 1);
        expect(result.dataOrNull!.first.storeName, 'Restaurant');
      });

      test('should be case-insensitive', () async {
        final result = await dataSource.searchCards('coffee');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
      });

      test('should return empty list for no matches', () async {
        final result = await dataSource.searchCards('NonExistent');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });

      test('should handle partial matches', () async {
        final result = await dataSource.searchCards('Coffee');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2); // Coffee Shop + Coffee House
      });
    });

    group('Soft Delete (Archive)', () {
      test('should archive card on delete', () async {
        final card = createTestCardModel();
        await dataSource.saveCard(card);

        await dataSource.deleteCard(card.id);

        final result = await dataSource.getCardById(card.id);
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.isArchived, isTrue);
        expect(result.dataOrNull!.id, card.id); // Still exists
      });

      test('should not throw when deleting non-existent card', () async {
        await dataSource.deleteCard('non_existent');
        // Should not throw
      });

      test('should preserve other cards when deleting', () async {
        final card1 = createTestCardModel(id: '1');
        final card2 = createTestCardModel(id: '2');

        await dataSource.saveCard(card1);
        await dataSource.saveCard(card2);

        await dataSource.deleteCard(card1.id);

        final allResult = await dataSource.getAllCards();
        expect(allResult.dataOrNull!.length, 2);

        final card1Result = await dataSource.getCardById(card1.id);
        expect(card1Result.dataOrNull!.isArchived, isTrue);

        final card2Result = await dataSource.getCardById(card2.id);
        expect(card2Result.dataOrNull!.isArchived, isFalse);
      });
    });

    group('Export/Import', () {
      test('should export cards', () async {
        final card = createTestCardModel();
        await dataSource.saveCard(card);

        final result = await dataSource.exportCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNotEmpty);
      });

      test('should handle import (even if not fully implemented)', () async {
        const encryptedData = 'test_data';
        final result = await dataSource.importCards(encryptedData);
        expect(result.isSuccess, isTrue);
        // Returns empty list for now (TODO in implementation)
        expect(result.dataOrNull, isEmpty);
      });
    });

    group('Error Handling', () {
      test('should handle errors gracefully', () async {
        // Test that operations don't crash
        await dataSource.getAllCards();
        await dataSource.searchCards('test');
        await dataSource.exportCards();
        await dataSource.importCards('data');
        // Should not throw
      });
    });
  });
}

/// Helper function to create test card model
LoyaltyCardModel createTestCardModel({
  String? id,
  String? name,
  String? storeName,
  String? barcodeData,
  String? format,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final now = DateTime.now();
  return LoyaltyCardModel(
    id: id ?? 'test_${now.millisecondsSinceEpoch}',
    name: name ?? 'Test Card',
    storeName: storeName ?? 'Test Store',
    barcodeData: barcodeData ?? 'TEST_123456',
    format: format ?? 'qrCode',
    createdAt: (createdAt ?? now).toIso8601String(),
    updatedAt: (updatedAt ?? now).toIso8601String(),
  );
}
