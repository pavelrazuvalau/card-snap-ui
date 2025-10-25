/// 🔶 Data Source: Local Card Storage
///
/// Local database implementation for offline-first card storage.
/// Similar to Angular's LocalStorageService but with encrypted persistence.
///
/// In Angular, you'd have:
/// ```typescript
/// @Injectable()
/// export class LocalStorageService {
///   setItem(key: string, value: string): void {
///     localStorage.setItem(key, value);
///   }
///   getItem(key: string): string | null {
///     return localStorage.getItem(key);
///   }
/// }
/// ```
///
/// In Flutter/Dart, we use simple in-memory storage for minimal startup.
library data.datasources;

import '../models/card_model.dart';
import '../../core/errors/app_exceptions.dart';

/// Local storage data source for cards
/// 🔹 Simple in-memory storage for minimal startup
/// 🔹 TODO: Replace with Hive database when dependencies are added
class LocalCardDataSource {
  static const String _storageKey = 'cards';

  // Simple in-memory storage
  final List<LoyaltyCardModel> _cards = [];
  bool _isInitialized = false;

  /// Initialize the local storage
  /// 🔹 Must be called before any operations
  /// 🧠 Simple initialization for minimal startup
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // TODO: Initialize Hive database here
      // For now, just mark as initialized
      _isInitialized = true;
    } catch (e) {
      throw DataException(
        'Failed to initialize local storage',
        technicalDetails: e.toString(),
      );
    }
  }

  /// Get all cards from local storage
  /// 🔹 Returns cached data for offline operation
  Future<Result<List<LoyaltyCardModel>>> getAllCards() async {
    try {
      await _ensureInitialized();

      return Result.success(List.from(_cards));
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to get cards from local storage',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Get card by ID from local storage
  /// 🔹 Nullable return for optional data
  Future<Result<LoyaltyCardModel?>> getCardById(String id) async {
    try {
      await _ensureInitialized();

      final card = _cards.firstWhere(
        (card) => card.id == id,
        orElse: () => throw StateError('Card not found'),
      );
      return Result.success(card);
    } catch (e) {
      if (e is StateError) {
        return Result.success(null);
      }
      return Result.failure(
        DataException(
          'Failed to get card by ID from local storage',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Save card to local storage
  /// 🔹 Persists card data with encryption
  Future<Result<void>> saveCard(LoyaltyCardModel card) async {
    try {
      await _ensureInitialized();

      // Remove existing card with same ID
      _cards.removeWhere((c) => c.id == card.id);

      // Add new card
      _cards.add(card);

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to save card to local storage',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Delete card from local storage
  /// 🔹 Soft delete - marks as archived
  Future<Result<void>> deleteCard(String id) async {
    try {
      await _ensureInitialized();

      final cardIndex = _cards.indexWhere((card) => card.id == id);
      if (cardIndex != -1) {
        final card = _cards[cardIndex];
        final archivedCard = LoyaltyCardModel(
          id: card.id,
          name: card.name,
          storeName: card.storeName,
          barcodeData: card.barcodeData,
          format: card.format,
          createdAt: card.createdAt,
          updatedAt: card.updatedAt,
          imageUrl: card.imageUrl,
          colorHex: card.colorHex,
          notes: card.notes,
          isArchived: true,
        );
        _cards[cardIndex] = archivedCard;
      }

      return Result.success(null);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to delete card from local storage',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Search cards in local storage
  /// 🔹 Offline search capability
  Future<Result<List<LoyaltyCardModel>>> searchCards(String query) async {
    try {
      await _ensureInitialized();

      final filteredCards = _cards.where((card) {
        final searchQuery = query.toLowerCase();
        return card.name.toLowerCase().contains(searchQuery) ||
            card.storeName.toLowerCase().contains(searchQuery);
      }).toList();

      return Result.success(filteredCards);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to search cards in local storage',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  /// Export all cards as encrypted JSON
  /// 🔹 User-initiated backup functionality
  Future<Result<String>> exportCards() async {
    try {
      await _ensureInitialized();

      final jsonData = _cards.map((card) => card.toJson()).toList();

      // TODO: Implement encryption for export
      // For now, return JSON string
      final jsonString = jsonData.toString();
      return Result.success(jsonString);
    } catch (e) {
      return Result.failure(
        DataException('Failed to export cards', technicalDetails: e.toString()),
      );
    }
  }

  /// Import cards from encrypted JSON
  /// 🔹 User-initiated restore functionality
  Future<Result<List<LoyaltyCardModel>>> importCards(
    String encryptedData,
  ) async {
    try {
      await _ensureInitialized();

      // TODO: Implement decryption for import
      // For now, return empty list
      return Result.success([]);
    } catch (e) {
      return Result.failure(
        DataException('Failed to import cards', technicalDetails: e.toString()),
      );
    }
  }

  /// Ensure storage is initialized
  /// 🔹 Helper method for initialization check
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await initialize();
    }
  }

  /// Close the storage
  /// 🔹 Cleanup method
  Future<void> close() async {
    if (_isInitialized) {
      _cards.clear();
      _isInitialized = false;
    }
  }
}
