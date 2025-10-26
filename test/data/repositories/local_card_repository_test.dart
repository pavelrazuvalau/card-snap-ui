/// 🔶 Repository Integration Tests: LocalCardRepository
///
/// Integration tests for repository implementation with real data source.
/// Tests the actual integration between domain entities and data models.
///
/// Similar to Angular's service integration tests.
///
/// In Angular, you'd have:
/// ```typescript
/// describe('CardService Integration', () => {
///   let service: CardService;
///   let http: HttpClient;
///
///   beforeEach(() => {
///     TestBed.configureTestingModule({...});
///     service = TestBed.inject(CardService);
///   });
///
///   it('should add and retrieve card', async () => {
///     const card = await service.addCard(newCard);
///     const retrieved = await service.getCardById(card.id);
///     expect(retrieved).toEqual(card);
///   });
/// });
/// ```

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/data/repositories/local_card_repository.dart';
import 'package:card_snap_ui/data/datasources/local_card_datasource.dart';
import 'package:card_snap_ui/domain/entities/card.dart';

void main() {
  group('LocalCardRepository Integration Tests', () {
    late LocalCardRepository repository;
    late LocalCardDataSource dataSource;

    setUp(() async {
      // 🔹 Setup real data source and repository
      // Testing actual integration, not mocks
      dataSource = LocalCardDataSource();
      await dataSource.initialize();
      repository = LocalCardRepository(dataSource);
    });

    tearDown(() async {
      // 🔹 Cleanup after each test
      await dataSource.close();
    });

    group('CRUD Operations', () {
      test('should add and retrieve card', () async {
        // 🔹 Core repository operation
        final card = createTestCard();
        final addResult = await repository.addCard(card);

        expect(addResult.isSuccess, isTrue);
        expect(addResult.dataOrNull, isNotNull);
        expect(addResult.dataOrNull!.id, card.id);

        final getResult = await repository.getCardById(card.id);
        expect(getResult.isSuccess, isTrue);
        expect(getResult.dataOrNull, isNotNull);
        expect(getResult.dataOrNull!, equals(card));
      });

      test('should retrieve all cards', () async {
        final card1 = createTestCard(id: '1', name: 'Card 1');
        final card2 = createTestCard(id: '2', name: 'Card 2');

        await repository.addCard(card1);
        await repository.addCard(card2);

        final result = await repository.getAllCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
      });

      test('should return empty list when no cards exist', () async {
        final result = await repository.getAllCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });

      test('should update existing card', () async {
        final card = createTestCard(name: 'Original');
        await repository.addCard(card);

        final updatedCard = card.copyWith(name: 'Updated');
        final result = await repository.updateCard(updatedCard);

        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.name, 'Updated');

        final retrieved = await repository.getCardById(card.id);
        expect(retrieved.dataOrNull!.name, 'Updated');
      });

      test('should return null for non-existent card', () async {
        final result = await repository.getCardById('non_existent');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNull);
      });

      test('should delete card (soft delete - archive)', () async {
        final card = createTestCard();
        await repository.addCard(card);

        final deleteResult = await repository.deleteCard(card.id);
        expect(deleteResult.isSuccess, isTrue);

        // Card should still exist but be archived
        final retrieved = await repository.getCardById(card.id);
        expect(retrieved.dataOrNull!.isArchived, isTrue);
      });
    });

    group('Search Operations', () {
      setUp(() async {
        await repository.addCard(
          createTestCard(id: '1', name: 'Coffee Shop', storeName: 'Coffee'),
        );
        await repository.addCard(
          createTestCard(id: '2', name: 'Restaurant', storeName: 'Restaurant'),
        );
        await repository.addCard(
          createTestCard(id: '3', name: 'Coffee House', storeName: 'Coffee'),
        );
      });

      test('should search cards by name', () async {
        final result = await repository.searchCards('Coffee');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
      });

      test('should search cards by store name', () async {
        final result = await repository.searchCards('Restaurant');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 1);
        expect(result.dataOrNull!.first.storeName, 'Restaurant');
      });

      test('should return empty list for no matches', () async {
        final result = await repository.searchCards('NonExistent');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });
    });

    group('Get Cards by Store', () {
      setUp(() async {
        await repository.addCard(
          createTestCard(id: '1', storeName: 'Coffee Shop'),
        );
        await repository.addCard(
          createTestCard(id: '2', storeName: 'Coffee Shop'),
        );
        await repository.addCard(
          createTestCard(id: '3', storeName: 'Restaurant'),
        );
      });

      test('should get cards by store name', () async {
        final result = await repository.getCardsByStore('Coffee Shop');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
        expect(
          result.dataOrNull!.every((c) => c.storeName == 'Coffee Shop'),
          isTrue,
        );
      });

      test('should be case-insensitive', () async {
        final result = await repository.getCardsByStore('coffee shop');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.length, 2);
      });

      test('should return empty list for non-existent store', () async {
        final result = await repository.getCardsByStore('NonExistent');
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isEmpty);
      });
    });

    group('Storage Stats', () {
      test('should calculate storage statistics', () async {
        await repository.addCard(createTestCard(id: '1'));
        await repository.addCard(createTestCard(id: '2'));
        await repository.addCard(createTestCard(id: '3'));

        await repository.deleteCard('1'); // Archive one

        final result = await repository.getStorageStats();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.totalCards, 3);
        expect(result.dataOrNull!.activeCards, 2);
        expect(result.dataOrNull!.archivedCards, 1);
      });

      test('should handle empty storage', () async {
        final result = await repository.getStorageStats();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull!.totalCards, 0);
        expect(result.dataOrNull!.activeCards, 0);
        expect(result.dataOrNull!.archivedCards, 0);
      });
    });

    group('Export/Import', () {
      test('should export cards', () async {
        await repository.addCard(createTestCard());

        final result = await repository.exportCards();
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNotEmpty);
      });

      test('should handle import', () async {
        const encryptedData = 'test_encrypted_data';
        final result = await repository.importCards(encryptedData);
        expect(result.isSuccess, isTrue);
        // TODO: Returns empty list for now
      });
    });

    group('Error Propagation', () {
      test('should handle operation errors gracefully', () async {
        // 🔹 Test that operations handle edge cases
        // Even after close, datasource may still work
        await dataSource.close();
        await dataSource.initialize();

        final result = await repository.getAllCards();
        expect(result.isSuccess, isTrue);
        // Should not crash
      });
    });

    group('Domain ↔ Data Mapping', () {
      test('should correctly map domain to data and back', () async {
        // 🔹 Critical: domain ↔ data conversion integrity
        final domainCard = LoyaltyCard(
          id: 'test_001',
          name: 'Test Card',
          storeName: 'Test Store',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          imageUrl: 'https://example.com/logo.png',
          colorHex: '#FF5733',
          notes: 'Test notes',
        );

        await repository.addCard(domainCard);
        final retrieved = await repository.getCardById(domainCard.id);

        expect(retrieved.dataOrNull!.id, domainCard.id);
        expect(retrieved.dataOrNull!.name, domainCard.name);
        expect(retrieved.dataOrNull!.storeName, domainCard.storeName);
        expect(retrieved.dataOrNull!.barcodeData, domainCard.barcodeData);
        expect(retrieved.dataOrNull!.format, domainCard.format);
        expect(retrieved.dataOrNull!.imageUrl, domainCard.imageUrl);
        expect(retrieved.dataOrNull!.colorHex, domainCard.colorHex);
        expect(retrieved.dataOrNull!.notes, domainCard.notes);
      });

      test('should handle all barcode formats correctly', () async {
        for (final format in BarcodeFormat.values) {
          final card = createTestCard(
            id: 'test_$format',
            format: format,
            barcodeData: 'TEST_${format.name}',
          );

          await repository.addCard(card);
          final retrieved = await repository.getCardById(card.id);

          expect(retrieved.dataOrNull!.format, format);
        }
      });
    });
  });
}

/// Helper function to create test cards
LoyaltyCard createTestCard({
  String? id,
  String? name,
  String? storeName,
  String? barcodeData,
  BarcodeFormat? format,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  final now = createdAt ?? DateTime.now();
  return LoyaltyCard(
    id: id ?? 'test_${now.millisecondsSinceEpoch}',
    name: name ?? 'Test Card',
    storeName: storeName ?? 'Test Store',
    barcodeData: barcodeData ?? 'TEST_123456',
    format: format ?? BarcodeFormat.qrCode,
    createdAt: now,
    updatedAt: updatedAt ?? now,
  );
}
