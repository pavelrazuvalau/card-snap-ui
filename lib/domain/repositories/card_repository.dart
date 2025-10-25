/// 🔶 Domain Repository Interface: CardRepository
/// 
/// Abstract contract for card data operations.
/// Similar to Angular's service interfaces but focused on data access patterns.
/// 
/// In Angular, you'd have:
/// ```typescript
/// export interface CardService {
///   getCards(): Observable<Card[]>;
///   addCard(card: Card): Observable<Card>;
///   updateCard(card: Card): Observable<Card>;
///   deleteCard(id: string): Observable<void>;
/// }
/// ```
/// 
/// In Flutter/Dart, we use repository pattern with Future-based async operations.
library domain.repositories;

import '../entities/card.dart';
import '../../core/errors/app_exceptions.dart';

/// Abstract repository for card data operations
/// 🔹 Dependency Inversion Principle - domain depends on abstractions
/// 🔹 Offline-first design - all operations work without network
abstract class CardRepository {
  /// Get all cards for the current user
  /// 🔹 Returns Future<List<LoyaltyCard>> - similar to Angular Observable<Card[]>
  /// 🧠 Offline-first: returns cached data when network unavailable
  Future<Result<List<LoyaltyCard>>> getAllCards();
  
  /// Get a specific card by ID
  /// 🔹 Nullable return for optional data
  Future<Result<LoyaltyCard?>> getCardById(String id);
  
  /// Add a new card
  /// 🔹 Immutable input - domain entity
  Future<Result<LoyaltyCard>> addCard(LoyaltyCard card);
  
  /// Update an existing card
  /// 🔹 Immutable input - domain entity
  Future<Result<LoyaltyCard>> updateCard(LoyaltyCard card);
  
  /// Delete a card (soft delete - archive)
  /// 🔹 Business rule: cards are archived, not permanently deleted
  Future<Result<void>> deleteCard(String id);
  
  /// Search cards by name or store
  /// 🔹 Offline search capability (from BUSINESS.md requirements)
  Future<Result<List<LoyaltyCard>>> searchCards(String query);
  
  /// Get cards by store name
  /// 🔹 Useful for grouping and filtering
  Future<Result<List<LoyaltyCard>>> getCardsByStore(String storeName);
  
  /// Export all cards for backup
  /// 🔹 User-initiated backup (from BUSINESS.md requirements)
  /// 🧠 Returns encrypted data for security
  Future<Result<String>> exportCards();
  
  /// Import cards from backup
  /// 🔹 User-initiated restore (from BUSINESS.md requirements)
  /// 🧠 Validates and decrypts imported data
  Future<Result<List<LoyaltyCard>>> importCards(String encryptedData);
  
  /// Get storage statistics
  /// 🔹 Useful for UI display and debugging
  Future<Result<StorageStats>> getStorageStats();
}

/// Storage statistics model
/// 🔹 Value object for storage information
class StorageStats {
  final int totalCards;
  final int activeCards;
  final int archivedCards;
  final int storageSizeBytes;
  final DateTime lastBackupDate;
  
  const StorageStats({
    required this.totalCards,
    required this.activeCards,
    required this.archivedCards,
    required this.storageSizeBytes,
    required this.lastBackupDate,
  });
}
