/// 🔶 Domain Entity Tests: LoyaltyCard
///
/// Comprehensive tests for the LoyaltyCard entity covering validation,
/// serialization, equality, and business logic.
///
/// Similar to Angular's unit tests for domain models but using Flutter test framework.
///
/// In Angular, you'd have:
/// ```typescript
/// describe('Card', () => {
///   it('should validate required fields', () => {
///     const card = new Card({...});
///     expect(card.isValid).toBe(true);
///   });
/// });
/// ```
///
/// In Flutter/Dart, we use test() blocks and expect() matchers.

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/domain/entities/card.dart';

void main() {
  group('LoyaltyCard Entity Tests', () {
    late LoyaltyCard validCard;
    late DateTime fixedDate;

    setUp(() {
      // 🔹 Setup test data before each test
      // Similar to Angular's beforeEach() in describe blocks
      fixedDate = DateTime(2023, 1, 15, 10, 30, 0);
      validCard = LoyaltyCard(
        id: 'card_test_001',
        name: 'Coffee Shop Card',
        storeName: 'Coffee Shop',
        barcodeData: 'QR_CODE_123456',
        format: BarcodeFormat.qrCode,
        createdAt: fixedDate,
        updatedAt: fixedDate,
        imageUrl: 'https://example.com/coffee.png',
        colorHex: '#FF5733',
        notes: 'My favorite coffee shop',
        isArchived: false,
      );
    });

    group('Constructor and Properties', () {
      test('should create a valid card with all properties', () {
        expect(validCard.id, 'card_test_001');
        expect(validCard.name, 'Coffee Shop Card');
        expect(validCard.storeName, 'Coffee Shop');
        expect(validCard.barcodeData, 'QR_CODE_123456');
        expect(validCard.format, BarcodeFormat.qrCode);
        expect(validCard.createdAt, fixedDate);
        expect(validCard.updatedAt, fixedDate);
        expect(validCard.imageUrl, 'https://example.com/coffee.png');
        expect(validCard.colorHex, '#FF5733');
        expect(validCard.notes, 'My favorite coffee shop');
        expect(validCard.isArchived, false);
      });

      test('should create a card with minimal required fields', () {
        final minimalCard = LoyaltyCard(
          id: 'card_test_002',
          name: 'Minimal Card',
          storeName: 'Store',
          barcodeData: '123',
          format: BarcodeFormat.code128,
          createdAt: fixedDate,
          updatedAt: fixedDate,
        );

        expect(minimalCard.imageUrl, isNull);
        expect(minimalCard.colorHex, isNull);
        expect(minimalCard.notes, isNull);
        expect(minimalCard.isArchived, false);
      });
    });

    group('copyWith Method', () {
      test('should create a copy with updated fields', () {
        // 🔹 Test immutable update pattern
        // Similar to Angular's immutability patterns in Redux/NgRx
        final updatedCard = validCard.copyWith(
          name: 'Updated Card Name',
          storeName: 'Updated Store',
          colorHex: '#00FF00',
        );

        expect(updatedCard.name, 'Updated Card Name');
        expect(updatedCard.storeName, 'Updated Store');
        expect(updatedCard.colorHex, '#00FF00');
        expect(updatedCard.id, validCard.id); // Unchanged
        expect(updatedCard.barcodeData, validCard.barcodeData); // Unchanged
      });

      test('should create a copy without changing any fields', () {
        final copiedCard = validCard.copyWith();
        expect(copiedCard.id, validCard.id);
        expect(copiedCard.name, validCard.name);
        expect(copiedCard.storeName, validCard.storeName);
      });

      test('should update only specified fields', () {
        final archivedCard = validCard.copyWith(isArchived: true);
        expect(archivedCard.isArchived, true);
        expect(archivedCard.name, validCard.name); // Unchanged
        expect(archivedCard.notes, validCard.notes); // Unchanged
      });
    });

    group('Serialization (JSON)', () {
      test('should convert card to JSON map', () {
        // 🔹 Test JSON serialization for data persistence
        // Similar to Angular's JSON.stringify() patterns
        final json = validCard.toJson();

        expect(json['id'], 'card_test_001');
        expect(json['name'], 'Coffee Shop Card');
        expect(json['storeName'], 'Coffee Shop');
        expect(json['barcodeData'], 'QR_CODE_123456');
        expect(json['format'], 'qrCode');
        expect(json['createdAt'], fixedDate.toIso8601String());
        expect(json['updatedAt'], fixedDate.toIso8601String());
        expect(json['imageUrl'], 'https://example.com/coffee.png');
        expect(json['colorHex'], '#FF5733');
        expect(json['notes'], 'My favorite coffee shop');
        expect(json['isArchived'], false);
      });

      test('should create card from JSON map', () {
        final json = validCard.toJson();
        final recreatedCard = LoyaltyCard.fromJson(json);

        expect(recreatedCard.id, validCard.id);
        expect(recreatedCard.name, validCard.name);
        expect(recreatedCard.storeName, validCard.storeName);
        expect(recreatedCard.barcodeData, validCard.barcodeData);
        expect(recreatedCard.format, validCard.format);
        expect(recreatedCard.createdAt, validCard.createdAt);
        expect(recreatedCard.updatedAt, validCard.updatedAt);
        expect(recreatedCard.imageUrl, validCard.imageUrl);
        expect(recreatedCard.colorHex, validCard.colorHex);
        expect(recreatedCard.notes, validCard.notes);
        expect(recreatedCard.isArchived, validCard.isArchived);
      });

      test('should handle null optional fields in JSON', () {
        final minimalJson = {
          'id': 'card_test_003',
          'name': 'Test Card',
          'storeName': 'Test Store',
          'barcodeData': '123',
          'format': 'code128',
          'createdAt': fixedDate.toIso8601String(),
          'updatedAt': fixedDate.toIso8601String(),
          'imageUrl': null,
          'colorHex': null,
          'notes': null,
          'isArchived': false,
        };

        final card = LoyaltyCard.fromJson(minimalJson);
        expect(card.imageUrl, isNull);
        expect(card.colorHex, isNull);
        expect(card.notes, isNull);
      });

      test('should handle serialization round-trip', () {
        // 🔹 Verify that serialization is symmetric (toJson + fromJson)
        final json = validCard.toJson();
        final recreatedCard = LoyaltyCard.fromJson(json);
        expect(recreatedCard, equals(validCard));
      });
    });

    group('Equality', () {
      test('should be equal when all fields match', () {
        final card1 = validCard;
        final card2 = LoyaltyCard(
          id: 'card_test_001',
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR_CODE_123456',
          format: BarcodeFormat.qrCode,
          createdAt: fixedDate,
          updatedAt: fixedDate,
          imageUrl: 'https://example.com/coffee.png',
          colorHex: '#FF5733',
          notes: 'My favorite coffee shop',
          isArchived: false,
        );

        expect(card1, equals(card2));
        expect(card1.hashCode, equals(card2.hashCode));
      });

      test('should not be equal when fields differ', () {
        final differentCard = validCard.copyWith(name: 'Different Name');
        expect(validCard, isNot(equals(differentCard)));
      });

      test('should not be equal to different type', () {
        expect(validCard, isNot(equals('not a card')));
        expect(validCard, isNot(equals(null)));
      });
    });

    group('toString', () {
      test('should return meaningful string representation', () {
        final stringRepresentation = validCard.toString();
        expect(stringRepresentation, contains('card_test_001'));
        expect(stringRepresentation, contains('Coffee Shop Card'));
        expect(stringRepresentation, contains('Coffee Shop'));
      });
    });

    group('BarcodeFormat Enum', () {
      test('should have all expected format values', () {
        // 🔹 Test enum completeness
        expect(BarcodeFormat.values.length, 6);
        expect(BarcodeFormat.values, contains(BarcodeFormat.qrCode));
        expect(BarcodeFormat.values, contains(BarcodeFormat.code128));
        expect(BarcodeFormat.values, contains(BarcodeFormat.ean13));
        expect(BarcodeFormat.values, contains(BarcodeFormat.upcA));
        expect(BarcodeFormat.values, contains(BarcodeFormat.code39));
        expect(BarcodeFormat.values, contains(BarcodeFormat.pdf417));
      });
    });

    group('Validation Extension', () {
      test('should validate a valid card', () {
        // 🔹 Business rule: cards must have valid barcode data
        expect(validCard.isValid, isTrue);
      });

      test('should fail validation when name is empty', () {
        final invalidCard = validCard.copyWith(name: '   ');
        expect(invalidCard.isValid, isFalse);
      });

      test('should fail validation when name is empty string', () {
        final invalidCard = validCard.copyWith(name: '');
        expect(invalidCard.isValid, isFalse);
      });

      test('should fail validation when storeName is empty', () {
        final invalidCard = validCard.copyWith(storeName: '  ');
        expect(invalidCard.isValid, isFalse);
      });

      test('should fail validation when barcodeData is empty', () {
        final invalidCard = validCard.copyWith(barcodeData: '');
        expect(invalidCard.isValid, isFalse);
      });

      test('should fail validation when createdAt is in the future', () {
        final futureDate = DateTime.now().add(const Duration(days: 1));
        final invalidCard = validCard.copyWith(createdAt: futureDate);
        expect(invalidCard.isValid, isFalse);
      });

      test('should fail validation when updatedAt is before createdAt', () {
        final earlierDate = fixedDate.subtract(const Duration(days: 1));
        final invalidCard = validCard.copyWith(updatedAt: earlierDate);
        expect(invalidCard.isValid, isFalse);
      });

      test('should pass validation with minimal required data', () {
        final minimalCard = LoyaltyCard(
          id: 'test_123',
          name: 'Name',
          storeName: 'Store',
          barcodeData: 'data',
          format: BarcodeFormat.qrCode,
          createdAt: fixedDate,
          updatedAt: fixedDate,
        );
        expect(minimalCard.isValid, isTrue);
      });
    });

    group('Format Display Name Extension', () {
      test('should return display name for QR Code', () {
        final qrCard = validCard.copyWith(format: BarcodeFormat.qrCode);
        expect(qrCard.formatDisplayName, 'QR Code');
      });

      test('should return display name for Code 128', () {
        final code128Card = validCard.copyWith(format: BarcodeFormat.code128);
        expect(code128Card.formatDisplayName, 'Code 128');
      });

      test('should return display name for EAN-13', () {
        final ean13Card = validCard.copyWith(format: BarcodeFormat.ean13);
        expect(ean13Card.formatDisplayName, 'EAN-13');
      });

      test('should return display name for UPC-A', () {
        final upcCard = validCard.copyWith(format: BarcodeFormat.upcA);
        expect(upcCard.formatDisplayName, 'UPC-A');
      });

      test('should return display name for Code 39', () {
        final code39Card = validCard.copyWith(format: BarcodeFormat.code39);
        expect(code39Card.formatDisplayName, 'Code 39');
      });

      test('should return display name for PDF417', () {
        final pdf417Card = validCard.copyWith(format: BarcodeFormat.pdf417);
        expect(pdf417Card.formatDisplayName, 'PDF417');
      });
    });
  });
}
