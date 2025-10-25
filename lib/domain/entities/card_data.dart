/// 🔶 Domain Entities - Card Data Transfer Object
///
/// Represents card data for operations and transfers.
/// Similar to Angular's DTOs for data transfer between layers.
library domain.entities.card_data;

/// Import LoyaltyCard from existing entities
import 'card.dart';

/// Card data transfer object
/// 🔶 Represents card data for operations
/// 🔹 Similar to Angular's DTOs for data transfer
/// 🧠 Immutable data structure for safe operations
class CardData {
  final String name;
  final String storeName;
  final String formatDisplayName;
  final String? imageUrl;
  final String? colorHex;

  const CardData({
    required this.name,
    required this.storeName,
    required this.formatDisplayName,
    this.imageUrl,
    this.colorHex,
  });

  /// Create CardData from LoyaltyCard entity
  /// 🔹 Factory method for conversion
  factory CardData.fromEntity(LoyaltyCard card) {
    return CardData(
      name: card.name,
      storeName: card.storeName,
      formatDisplayName: card.formatDisplayName,
      imageUrl: card.imageUrl,
      colorHex: card.colorHex,
    );
  }
}
