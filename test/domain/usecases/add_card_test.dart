/// 🔶 Use Case Tests: AddCard
///
/// Comprehensive tests for the AddCard use case covering business logic,
/// validation, duplicate detection, and error handling.
///
/// Similar to Angular's service tests but focused on business operations.
///
/// In Angular, you'd have:
/// ```typescript
/// describe('AddCardService', () => {
///   it('should add a valid card', async () => {
///     const service = new AddCardService(mockRepository);
///     const result = await service.addCard(cardData);
///     expect(result).toBeTruthy();
///   });
/// });
/// ```
///
/// In Flutter/Dart, we use test() blocks with mocktail for mocking.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:card_snap_ui/domain/usecases/add_card.dart';
import 'package:card_snap_ui/domain/repositories/card_repository.dart';
import 'package:card_snap_ui/domain/entities/card.dart';
import 'package:card_snap_ui/core/errors/app_exceptions.dart';

/// Mock repository for testing
/// 🔹 Similar to Angular's Jasmine spies or Jest mocks
class MockCardRepository extends Mock implements CardRepository {}

/// Helper function to create a test card
LoyaltyCard createTestCard({
  String? id,
  String? name,
  String? storeName,
  String? barcodeData,
  BarcodeFormat? format,
  DateTime? createdAt,
  DateTime? updatedAt,
}) {
  return LoyaltyCard(
    id: id ?? 'test_card_001',
    name: name ?? 'Test Card',
    storeName: storeName ?? 'Test Store',
    barcodeData: barcodeData ?? 'TEST_123456',
    format: format ?? BarcodeFormat.qrCode,
    createdAt: createdAt ?? DateTime.now(),
    updatedAt: updatedAt ?? DateTime.now(),
  );
}

void main() {
  group('AddCard Use Case Tests', () {
    late AddCard addCard;
    late MockCardRepository mockRepository;

    setUpAll(() {
      // 🔹 Register fallback values for mocktail
      // Required for using any() matcher with complex types
      registerFallbackValue(createTestCard());
    });

    setUp(() {
      // 🔹 Setup test doubles before each test
      // Similar to Angular's beforeEach() with mock services
      mockRepository = MockCardRepository();
      addCard = AddCard(mockRepository);
    });

    group('Execute Method', () {
      test('should successfully add a valid card', () async {
        // 🔹 Test successful card addition
        // Similar to Angular's happy path testing
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        // Mock repository to return empty list (no duplicates)
        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => const Result.success([]));

        // Mock successful card addition - return the card that was passed in
        when(() => mockRepository.addCard(any())).thenAnswer((
          invocation,
        ) async {
          final card = invocation.positionalArguments[0] as LoyaltyCard;
          return Result.success(card);
        });

        // Execute the use case
        final result = await addCard.execute(request);

        // Verify success
        expect(result.isSuccess, isTrue);
        expect(result.dataOrNull, isNotNull);
        expect(result.dataOrNull?.name, 'Coffee Shop Card');
        expect(result.dataOrNull?.storeName, 'Coffee Shop');
        expect(result.dataOrNull?.barcodeData, 'QR123456');

        // Verify repository was called
        verify(() => mockRepository.getAllCards()).called(1);
        verify(() => mockRepository.addCard(any())).called(1);
      });

      test('should fail when request is invalid', () async {
        // 🔹 Test validation failure
        const request = AddCardRequest(
          name: '', // Empty name
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        // Execute the use case
        final result = await addCard.execute(request);

        // Verify failure
        expect(result.isFailure, isTrue);
        expect(result.errorOrNull?.message, 'Invalid card data provided');

        // Verify repository was not called (no need to verify with mocks in this case)
      });

      test('should fail when barcodeData is empty', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: '', // Empty barcode
          format: BarcodeFormat.qrCode,
        );

        final result = await addCard.execute(request);

        expect(result.isFailure, isTrue);
        expect(result.errorOrNull?.message, 'Invalid card data provided');
      });

      test('should fail when storeName is empty', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: '', // Empty store name
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        final result = await addCard.execute(request);

        expect(result.isFailure, isTrue);
        expect(result.errorOrNull?.message, 'Invalid card data provided');
      });

      test('should fail when duplicate card exists', () async {
        // 🔹 Test duplicate detection business rule
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        final existingCard = LoyaltyCard(
          id: 'card_123',
          name: 'Existing Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456', // Same barcode
          format: BarcodeFormat.qrCode,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // Mock repository to return existing card
        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => Result.success([existingCard]));

        // Execute the use case
        final result = await addCard.execute(request);

        // Verify failure due to duplicate
        expect(result.isFailure, isTrue);
        expect(
          result.errorOrNull?.message,
          'Card with this barcode already exists',
        );

        // Verify repository was called for checking duplicates
        verify(() => mockRepository.getAllCards()).called(1);
      });

      test('should handle case-insensitive store name matching', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'coffee shop', // Lowercase
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        final existingCard = LoyaltyCard(
          id: 'card_123',
          name: 'Existing Card',
          storeName: 'Coffee Shop', // Different case
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => Result.success([existingCard]));

        final result = await addCard.execute(request);

        expect(result.isFailure, isTrue);
        expect(
          result.errorOrNull?.message,
          'Card with this barcode already exists',
        );

        // Verify repository was called for checking duplicates
        verify(() => mockRepository.getAllCards()).called(1);
      });

      test('should fail when repository getAllCards fails', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        // Mock repository failure
        when(() => mockRepository.getAllCards()).thenAnswer(
          (_) async =>
              const Result.failure(DataException('Failed to get cards')),
        );

        // Execute the use case
        final result = await addCard.execute(request);

        // Verify failure propagated
        expect(result.isFailure, isTrue);
        expect(result.errorOrNull?.message, 'Failed to get cards');
      });

      test('should fail when repository addCard fails', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => const Result.success([]));

        // Mock repository failure on add
        when(() => mockRepository.addCard(any())).thenAnswer(
          (_) async =>
              const Result.failure(DataException('Failed to save card')),
        );

        // Execute the use case
        final result = await addCard.execute(request);

        // Verify failure propagated
        expect(result.isFailure, isTrue);
        expect(result.errorOrNull?.message, 'Failed to save card');
      });

      test('should trim whitespace from card data', () async {
        // 🔹 Test data sanitization
        const request = AddCardRequest(
          name: '  Coffee Shop Card  ', // With whitespace
          storeName: '  Coffee Shop  ',
          barcodeData: '  QR123456  ',
          format: BarcodeFormat.qrCode,
        );

        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => const Result.success([]));

        LoyaltyCard? capturedCard;
        when(() => mockRepository.addCard(any())).thenAnswer((
          invocation,
        ) async {
          capturedCard = invocation.positionalArguments[0] as LoyaltyCard;
          return Result.success(capturedCard!);
        });

        final result = await addCard.execute(request);

        expect(result.isSuccess, isTrue);
        expect(capturedCard, isNotNull);
        final card = capturedCard!;
        expect(card.name, 'Coffee Shop Card'); // Trimmed
        expect(card.storeName, 'Coffee Shop'); // Trimmed
        expect(card.barcodeData, 'QR123456'); // Trimmed
      });

      test('should generate unique card ID', () async {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        when(
          () => mockRepository.getAllCards(),
        ).thenAnswer((_) async => const Result.success([]));

        LoyaltyCard? capturedCard;
        when(() => mockRepository.addCard(any())).thenAnswer((
          invocation,
        ) async {
          capturedCard = invocation.positionalArguments[0] as LoyaltyCard;
          return Result.success(capturedCard!);
        });

        await addCard.execute(request);

        // Verify that a card was added with a unique ID
        expect(capturedCard, isNotNull);
        final card = capturedCard!;
        expect(card.id, isNotNull);
        expect(card.id, startsWith('card_'));
      });
    });

    group('AddCardRequest Validation', () {
      test('should validate request with all required fields', () {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        expect(request.isValid, isTrue);
      });

      test('should fail validation with empty name', () {
        const request = AddCardRequest(
          name: '',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        expect(request.isValid, isFalse);
      });

      test('should fail validation with empty storeName', () {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: '',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
        );

        expect(request.isValid, isFalse);
      });

      test('should fail validation with empty barcodeData', () {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: '',
          format: BarcodeFormat.qrCode,
        );

        expect(request.isValid, isFalse);
      });

      test('should include optional fields', () {
        const request = AddCardRequest(
          name: 'Coffee Shop Card',
          storeName: 'Coffee Shop',
          barcodeData: 'QR123456',
          format: BarcodeFormat.qrCode,
          imageUrl: 'https://example.com/image.png',
          colorHex: '#FF5733',
          notes: 'Favorite coffee shop',
        );

        expect(request.imageUrl, 'https://example.com/image.png');
        expect(request.colorHex, '#FF5733');
        expect(request.notes, 'Favorite coffee shop');
      });
    });
  });
}
