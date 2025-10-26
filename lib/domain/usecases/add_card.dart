/// 🔶 Domain Use Case: AddCard
///
/// Business operation for adding a new loyalty card.
/// Similar to Angular service methods but focused on single business operations.
///
/// In Angular, you'd have:
/// ```typescript
/// @Injectable()
/// export class CardService {
///   addCard(cardData: AddCardRequest): Observable<Card> {
///     // Validation
///     // Business logic
///     // Repository call
///   }
/// }
/// ```
///
/// In Flutter/Dart, we use dedicated use case classes for single operations.
library domain.usecases;

import '../entities/card.dart';
import '../repositories/card_repository.dart';
import '../../core/errors/app_exceptions.dart';

/// Request model for adding a card
/// 🔹 Immutable input model (like Angular request DTOs)
class AddCardRequest {
  final String name;
  final String storeName;
  final String barcodeData;
  final BarcodeFormat format;
  final String? imageUrl;
  final String? colorHex;
  final String? notes;

  const AddCardRequest({
    required this.name,
    required this.storeName,
    required this.barcodeData,
    required this.format,
    this.imageUrl,
    this.colorHex,
    this.notes,
  });

  /// Validate request data
  /// 🔹 Business validation before processing
  bool get isValid {
    if (name.trim().isEmpty) return false;
    if (storeName.trim().isEmpty) return false;
    if (barcodeData.trim().isEmpty) return false;
    return true;
  }
}

/// Use case for adding a new card
/// 🔶 Single Responsibility Principle - one business operation
/// 🔹 Pure domain logic - no UI or framework dependencies
class AddCard {
  final CardRepository repository;

  /// Constructor injection (like Angular dependency injection)
  /// 🔹 Depends on abstraction, not implementation
  const AddCard(this.repository);

  /// Execute the use case
  /// 🔹 Main business operation
  /// 🧠 Offline-first: works without network connectivity
  Future<Result<LoyaltyCard>> execute(AddCardRequest request) async {
    try {
      // Business validation
      if (!request.isValid) {
        return const Result.failure(
          DomainException('Invalid card data provided'),
        );
      }

      // Check for duplicate cards
      final existingCardsResult = await repository.getAllCards();
      if (existingCardsResult.isFailure) {
        return Result.failure(existingCardsResult.errorOrNull!);
      }

      final existingCards = existingCardsResult.dataOrNull!;
      final isDuplicate = existingCards.any(
        (card) =>
            card.barcodeData == request.barcodeData &&
            card.storeName.toLowerCase() == request.storeName.toLowerCase(),
      );

      if (isDuplicate) {
        return const Result.failure(
          DomainException('Card with this barcode already exists'),
        );
      }

      // Create domain entity
      final now = DateTime.now();
      final card = LoyaltyCard(
        id: _generateCardId(),
        name: request.name.trim(),
        storeName: request.storeName.trim(),
        barcodeData: request.barcodeData.trim(),
        format: request.format,
        createdAt: now,
        updatedAt: now,
        imageUrl: request.imageUrl,
        colorHex: request.colorHex,
        notes: request.notes,
      );

      // Validate entity
      if (!card.isValid) {
        return const Result.failure(
          DomainException('Generated card data is invalid'),
        );
      }

      // Persist through repository
      final result = await repository.addCard(card);
      return result;
    } catch (e) {
      return Result.failure(
        DomainException(
          'Failed to add card: ${e.toString()}',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Generate unique card ID
  /// 🔹 Business logic for ID generation
  /// 🧠 Uses timestamp + random for uniqueness
  String _generateCardId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'card_${timestamp}_$random';
  }
}
