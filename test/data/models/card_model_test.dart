/// 🔶 Data Model Tests: LoyaltyCardModel
///
/// Tests for data model serialization and domain conversion.
/// Critical for offline-first architecture - wrong serialization = data loss.
///
/// Similar to Angular's DTO (Data Transfer Object) tests.
///
/// In Angular, you'd have:
/// ```typescript
/// describe('CardDto', () => {
///   it('should serialize card correctly', () => {
///     const dto = new CardDto({...});
///     const json = JSON.stringify(dto);
///     expect(json).toContain('name');
///   });
/// });
/// ```

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/data/models/card_model.dart';
import 'package:card_snap_ui/domain/entities/card.dart';

void main() {
  group('LoyaltyCardModel Tests', () {
    late LoyaltyCardModel model;
    final fixedDate = DateTime(2023, 1, 15, 10, 30, 0);

    setUp(() {
      // 🔹 Setup test data before each test
      model = LoyaltyCardModel(
        id: 'model_test_001',
        name: 'Coffee Shop Card',
        storeName: 'Coffee Shop',
        barcodeData: 'QR_CODE_123456',
        format: 'qrCode',
        createdAt: fixedDate.toIso8601String(),
        updatedAt: fixedDate.toIso8601String(),
        imageUrl: 'https://example.com/coffee.png',
        colorHex: '#FF5733',
        notes: 'My favorite coffee shop',
        isArchived: false,
      );
    });

    group('Constructor and Properties', () {
      test('should create model with all properties', () {
        expect(model.id, 'model_test_001');
        expect(model.name, 'Coffee Shop Card');
        expect(model.storeName, 'Coffee Shop');
        expect(model.barcodeData, 'QR_CODE_123456');
        expect(model.format, 'qrCode');
        expect(model.createdAt, fixedDate.toIso8601String());
        expect(model.updatedAt, fixedDate.toIso8601String());
        expect(model.imageUrl, 'https://example.com/coffee.png');
        expect(model.colorHex, '#FF5733');
        expect(model.notes, 'My favorite coffee shop');
        expect(model.isArchived, false);
      });

      test('should create model with minimal fields', () {
        final minimalModel = LoyaltyCardModel(
          id: 'minimal_001',
          name: 'Minimal Card',
          storeName: 'Store',
          barcodeData: '123',
          format: 'code128',
          createdAt: fixedDate.toIso8601String(),
          updatedAt: fixedDate.toIso8601String(),
        );

        expect(minimalModel.imageUrl, isNull);
        expect(minimalModel.colorHex, isNull);
        expect(minimalModel.notes, isNull);
        expect(minimalModel.isArchived, false);
      });
    });

    group('JSON Serialization', () {
      test('should convert model to JSON map', () {
        // 🔹 Test JSON serialization for data persistence
        // Critical for offline storage and backups
        final json = model.toJson();

        expect(json['id'], 'model_test_001');
        expect(json['name'], 'Coffee Shop Card');
        expect(json['store_name'], 'Coffee Shop'); // 🔹 snake_case for API
        expect(json['barcode_data'], 'QR_CODE_123456');
        expect(json['format'], 'qrCode');
        expect(json['created_at'], fixedDate.toIso8601String());
        expect(json['updated_at'], fixedDate.toIso8601String());
        expect(json['image_url'], 'https://example.com/coffee.png');
        expect(json['color_hex'], '#FF5733');
        expect(json['notes'], 'My favorite coffee shop');
        expect(json['is_archived'], false);
      });

      test('should create model from JSON map', () {
        // 🔹 Test JSON deserialization
        // Critical for restoring data from storage
        final json = model.toJson();
        final recreatedModel = LoyaltyCardModel.fromJson(json);

        expect(recreatedModel.id, model.id);
        expect(recreatedModel.name, model.name);
        expect(recreatedModel.storeName, model.storeName);
        expect(recreatedModel.barcodeData, model.barcodeData);
        expect(recreatedModel.format, model.format);
        expect(recreatedModel.createdAt, model.createdAt);
        expect(recreatedModel.updatedAt, model.updatedAt);
        expect(recreatedModel.imageUrl, model.imageUrl);
        expect(recreatedModel.colorHex, model.colorHex);
        expect(recreatedModel.notes, model.notes);
        expect(recreatedModel.isArchived, model.isArchived);
      });

      test('should handle null optional fields in JSON', () {
        // 🔹 Critical for backward compatibility
        final minimalJson = {
          'id': 'test_001',
          'name': 'Test Card',
          'store_name': 'Test Store',
          'barcode_data': '123',
          'format': 'code128',
          'created_at': fixedDate.toIso8601String(),
          'updated_at': fixedDate.toIso8601String(),
          'image_url': null,
          'color_hex': null,
          'notes': null,
          'is_archived': false,
        };

        final recreatedModel = LoyaltyCardModel.fromJson(minimalJson);
        expect(recreatedModel.imageUrl, isNull);
        expect(recreatedModel.colorHex, isNull);
        expect(recreatedModel.notes, isNull);
      });

      test('should handle serialization round-trip', () {
        // 🔹 Verify serialization is symmetric
        final json = model.toJson();
        final recreatedModel = LoyaltyCardModel.fromJson(json);
        expect(recreatedModel, equals(model));
      });
    });

    group('Domain Conversion', () {
      test('should convert model to domain entity', () {
        // 🔹 Critical for repository pattern
        // Data layer → Domain layer conversion
        final domainCard = model.toDomain();

        expect(domainCard.id, model.id);
        expect(domainCard.name, model.name);
        expect(domainCard.storeName, model.storeName);
        expect(domainCard.barcodeData, model.barcodeData);
        expect(domainCard.format, BarcodeFormat.qrCode);
        expect(domainCard.imageUrl, model.imageUrl);
        expect(domainCard.colorHex, model.colorHex);
        expect(domainCard.notes, model.notes);
        expect(domainCard.isArchived, model.isArchived);
      });

      test('should convert different barcode formats correctly', () {
        final code128Model = model.copyWith(format: 'code128');
        final domainCard = code128Model.toDomain();

        expect(domainCard.format, BarcodeFormat.code128);
      });

      test('should handle invalid barcode format', () {
        // 🔹 Fallback to qrCode if format is unknown
        final invalidModel = model.copyWith(format: 'unknown_format');
        final domainCard = invalidModel.toDomain();

        // Should fallback to qrCode
        expect(domainCard.format, BarcodeFormat.qrCode);
      });

      test('should convert with fromDomain factory', () {
        // 🔹 Domain → Data conversion
        final domainCard = LoyaltyCard(
          id: 'domain_001',
          name: 'Domain Card',
          storeName: 'Store',
          barcodeData: '123',
          format: BarcodeFormat.ean13,
          createdAt: fixedDate,
          updatedAt: fixedDate,
        );

        final model = LoyaltyCardModel.fromDomain(domainCard);

        expect(model.id, domainCard.id);
        expect(model.name, domainCard.name);
        expect(model.storeName, domainCard.storeName);
        expect(model.barcodeData, domainCard.barcodeData);
        expect(model.format, 'ean13');
        expect(model.createdAt, domainCard.createdAt.toIso8601String());
        expect(model.updatedAt, domainCard.updatedAt.toIso8601String());
      });

      test('should maintain data integrity through conversion', () {
        // 🔹 Data integrity: Domain → Model → Domain
        final originalDomain = LoyaltyCard(
          id: 'test_001',
          name: 'Test Card',
          storeName: 'Test Store',
          barcodeData: 'QR123',
          format: BarcodeFormat.pdf417,
          createdAt: fixedDate,
          updatedAt: fixedDate,
          imageUrl: 'https://example.com/logo.png',
          colorHex: '#00FF00',
          notes: 'Test notes',
          isArchived: false,
        );

        final model = LoyaltyCardModel.fromDomain(originalDomain);
        final recreatedDomain = model.toDomain();

        expect(recreatedDomain.id, originalDomain.id);
        expect(recreatedDomain.name, originalDomain.name);
        expect(recreatedDomain.storeName, originalDomain.storeName);
        expect(recreatedDomain.barcodeData, originalDomain.barcodeData);
        expect(recreatedDomain.format, originalDomain.format);
        expect(recreatedDomain.createdAt, originalDomain.createdAt);
        expect(recreatedDomain.updatedAt, originalDomain.updatedAt);
        expect(recreatedDomain.imageUrl, originalDomain.imageUrl);
        expect(recreatedDomain.colorHex, originalDomain.colorHex);
        expect(recreatedDomain.notes, originalDomain.notes);
        expect(recreatedDomain.isArchived, originalDomain.isArchived);
      });
    });

    group('Equality', () {
      test('should be equal when all fields match', () {
        final model1 = model;
        final model2 = LoyaltyCardModel(
          id: 'model_test_001',
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR_CODE_123456',
          format: 'qrCode',
          createdAt: fixedDate.toIso8601String(),
          updatedAt: fixedDate.toIso8601String(),
          imageUrl: 'https://example.com/coffee.png',
          colorHex: '#FF5733',
          notes: 'My favorite coffee shop',
          isArchived: false,
        );

        expect(model1, equals(model2));
        expect(model1.hashCode, equals(model2.hashCode));
      });

      test('should not be equal when fields differ', () {
        final differentModel = model.copyWith(name: 'Different Name');
        expect(model, isNot(equals(differentModel)));
      });
    });

    group('Copy with Method', () {
      test('should create copy with updated fields', () {
        final updatedModel = model.copyWith(
          name: 'Updated Card',
          isArchived: true,
        );

        expect(updatedModel.name, 'Updated Card');
        expect(updatedModel.isArchived, true);
        expect(updatedModel.id, model.id); // Unchanged
        expect(updatedModel.storeName, model.storeName); // Unchanged
      });
    });
  });

  group('All Barcode Formats', () {
    test('should support all barcode formats', () {
      final formats = [
        'qrCode',
        'code128',
        'ean13',
        'upcA',
        'code39',
        'pdf417',
      ];

      for (final format in formats) {
        final model = LoyaltyCardModel(
          id: 'test_$format',
          name: 'Test',
          storeName: 'Store',
          barcodeData: '123',
          format: format,
          createdAt: DateTime.now().toIso8601String(),
          updatedAt: DateTime.now().toIso8601String(),
        );

        final domain = model.toDomain();
        expect(domain.format.name, format);
      }
    });
  });
}
