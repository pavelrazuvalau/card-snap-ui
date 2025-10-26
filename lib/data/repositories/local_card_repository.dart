/// 🔶 Repository Implementation: Local Card Repository
///
/// Local implementation of CardRepository using offline storage.
/// Similar to Angular's service implementation but focused on data persistence.
///
/// In Angular, you'd have:
/// ```typescript
/// @Injectable()
/// export class CardService implements ICardService {
///   constructor(private http: HttpClient) {}
///
///   async getCards(): Promise<Card[]> {
///     const response = await this.http.get<CardDto[]>('/api/cards').toPromise();
///     return response.map(dto => this.mapToDomain(dto));
///   }
/// }
/// ```
///
/// In Flutter/Dart, we implement repository interfaces with data sources.
library data.repositories;

import '../datasources/local_card_datasource.dart';
import '../models/card_model.dart';
import '../../domain/entities/card.dart';
import '../../domain/repositories/card_repository.dart';
import '../../core/errors/app_exceptions.dart';

/// Local implementation of CardRepository
/// 🔹 Implements domain interface using local storage
/// 🔹 Offline-first approach (from BUSINESS.md requirements)
class LocalCardRepository implements CardRepository {
  final LocalCardDataSource _dataSource;

  /// Constructor injection
  /// 🔹 Depends on data source abstraction
  const LocalCardRepository(this._dataSource);

  @override
  Future<Result<List<LoyaltyCard>>> getAllCards() async {
    try {
      final result = await _dataSource.getAllCards();

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      final cardModels = result.dataOrNull!;
      final cards = cardModels.map((model) => model.toDomain()).toList();

      return Result.success(cards);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to get all cards',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<LoyaltyCard?>> getCardById(String id) async {
    try {
      final result = await _dataSource.getCardById(id);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      final cardModel = result.dataOrNull;
      final card = cardModel?.toDomain();

      return Result.success(card);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to get card by ID',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<LoyaltyCard>> addCard(LoyaltyCard card) async {
    try {
      final cardModel = LoyaltyCardModel.fromDomain(card);
      final result = await _dataSource.saveCard(cardModel);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      return Result.success(card);
    } catch (e) {
      return Result.failure(
        DataException('Failed to add card', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<LoyaltyCard>> updateCard(LoyaltyCard card) async {
    try {
      final cardModel = LoyaltyCardModel.fromDomain(card);
      final result = await _dataSource.saveCard(cardModel);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      return Result.success(card);
    } catch (e) {
      return Result.failure(
        DataException('Failed to update card', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<void>> deleteCard(String id) async {
    try {
      final result = await _dataSource.deleteCard(id);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      return const Result.success(null);
    } catch (e) {
      return Result.failure(
        DataException('Failed to delete card', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<LoyaltyCard>>> searchCards(String query) async {
    try {
      final result = await _dataSource.searchCards(query);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      final cardModels = result.dataOrNull!;
      final cards = cardModels.map((model) => model.toDomain()).toList();

      return Result.success(cards);
    } catch (e) {
      return Result.failure(
        DataException('Failed to search cards', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<LoyaltyCard>>> getCardsByStore(String storeName) async {
    try {
      // Use search functionality to filter by store
      final result = await searchCards(storeName);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      final allCards = result.dataOrNull!;
      final storeCards = allCards
          .where(
            (card) => card.storeName.toLowerCase() == storeName.toLowerCase(),
          )
          .toList();

      return Result.success(storeCards);
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to get cards by store',
          technicalDetails: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<String>> exportCards() async {
    try {
      final result = await _dataSource.exportCards();

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      return Result.success(result.dataOrNull!);
    } catch (e) {
      return Result.failure(
        DataException('Failed to export cards', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<List<LoyaltyCard>>> importCards(String encryptedData) async {
    try {
      final result = await _dataSource.importCards(encryptedData);

      if (result.isFailure) {
        return Result.failure(result.errorOrNull!);
      }

      final cardModels = result.dataOrNull!;
      final cards = cardModels.map((model) => model.toDomain()).toList();

      return Result.success(cards);
    } catch (e) {
      return Result.failure(
        DataException('Failed to import cards', technicalDetails: e.toString()),
      );
    }
  }

  @override
  Future<Result<StorageStats>> getStorageStats() async {
    try {
      final allCardsResult = await getAllCards();

      if (allCardsResult.isFailure) {
        return Result.failure(allCardsResult.errorOrNull!);
      }

      final allCards = allCardsResult.dataOrNull!;
      final activeCards = allCards.where((card) => !card.isArchived).length;
      final archivedCards = allCards.where((card) => card.isArchived).length;

      // TODO: Calculate actual storage size
      const storageSizeBytes = 0;

      return Result.success(
        StorageStats(
          totalCards: allCards.length,
          activeCards: activeCards,
          archivedCards: archivedCards,
          storageSizeBytes: storageSizeBytes,
          lastBackupDate: DateTime.now(), // TODO: Track actual backup date
        ),
      );
    } catch (e) {
      return Result.failure(
        DataException(
          'Failed to get storage stats',
          technicalDetails: e.toString(),
        ),
      );
    }
  }
}
