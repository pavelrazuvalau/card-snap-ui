/// 🔶 Data Model: LoyaltyCardModel
///
/// Data Transfer Object for card serialization and API communication.
/// Similar to Angular's DTOs but with JSON serialization annotations.
///
/// In Angular, you'd have:
/// ```typescript
/// export interface CardDto {
///   id: string;
///   name: string;
///   store_name: string;
///   barcode_data: string;
///   format: string;
///   created_at: string;
///   updated_at: string;
/// }
/// ```
///
/// In Flutter/Dart, we use data models with JSON serialization.
///
/// See STYLEGUIDE.md#81-immutable-models (§8.1) for Immutable Models guidelines,
/// STYLEGUIDE.md#32-const-constructors (§3.2) for const constructors, and STYLEGUIDE.md#22-dart-syntax-explained-with-angulartypescript-analogies (§2.2) for factory methods.
library data.models;

import '../../domain/entities/card.dart';

/// Data model for card serialization
/// 🔹 Maps between domain entities and external data formats
/// 🔹 Handles JSON serialization/deserialization
class LoyaltyCardModel {
  final String id;
  final String name;
  final String storeName;
  final String barcodeData;
  final String format;
  final String createdAt;
  final String updatedAt;
  final String? imageUrl;
  final String? colorHex;
  final String? notes;
  final bool isArchived;

  const LoyaltyCardModel({
    required this.id,
    required this.name,
    required this.storeName,
    required this.barcodeData,
    required this.format,
    required this.createdAt,
    required this.updatedAt,
    this.imageUrl,
    this.colorHex,
    this.notes,
    this.isArchived = false,
  });

  /// Convert to JSON map
  /// 🔹 Simple serialization for data persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'store_name': storeName,
      'barcode_data': barcodeData,
      'format': format,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_url': imageUrl,
      'color_hex': colorHex,
      'notes': notes,
      'is_archived': isArchived,
    };
  }

  /// Create from JSON map
  /// 🔹 Simple deserialization from data persistence
  factory LoyaltyCardModel.fromJson(Map<String, dynamic> json) {
    return LoyaltyCardModel(
      id: json['id'] as String,
      name: json['name'] as String,
      storeName: json['store_name'] as String,
      barcodeData: json['barcode_data'] as String,
      format: json['format'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      imageUrl: json['image_url'] as String?,
      colorHex: json['color_hex'] as String?,
      notes: json['notes'] as String?,
      isArchived: json['is_archived'] as bool? ?? false,
    );
  }

  /// Convert from domain entity
  /// 🔹 Domain → Data mapping
  factory LoyaltyCardModel.fromDomain(LoyaltyCard card) {
    return LoyaltyCardModel(
      id: card.id,
      name: card.name,
      storeName: card.storeName,
      barcodeData: card.barcodeData,
      format: card.format.name,
      createdAt: card.createdAt.toIso8601String(),
      updatedAt: card.updatedAt.toIso8601String(),
      imageUrl: card.imageUrl,
      colorHex: card.colorHex,
      notes: card.notes,
      isArchived: card.isArchived,
    );
  }

  /// Create a copy with updated fields
  /// 🔹 Immutable update pattern (similar to domain entity)
  LoyaltyCardModel copyWith({
    String? id,
    String? name,
    String? storeName,
    String? barcodeData,
    String? format,
    String? createdAt,
    String? updatedAt,
    String? imageUrl,
    String? colorHex,
    String? notes,
    bool? isArchived,
  }) {
    return LoyaltyCardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      storeName: storeName ?? this.storeName,
      barcodeData: barcodeData ?? this.barcodeData,
      format: format ?? this.format,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      colorHex: colorHex ?? this.colorHex,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoyaltyCardModel &&
        other.id == id &&
        other.name == name &&
        other.storeName == storeName &&
        other.barcodeData == barcodeData &&
        other.format == format &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.imageUrl == imageUrl &&
        other.colorHex == colorHex &&
        other.notes == notes &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      storeName,
      barcodeData,
      format,
      createdAt,
      updatedAt,
      imageUrl,
      colorHex,
      notes,
      isArchived,
    );
  }

  @override
  String toString() {
    return 'LoyaltyCardModel(id: $id, name: $name, storeName: $storeName)';
  }
}

/// Extension for converting to domain entity
/// 🔹 Data → Domain mapping
extension LoyaltyCardModelToDomain on LoyaltyCardModel {
  /// Convert to domain entity
  LoyaltyCard toDomain() {
    return LoyaltyCard(
      id: id,
      name: name,
      storeName: storeName,
      barcodeData: barcodeData,
      format: BarcodeFormat.values.firstWhere(
        (f) => f.name == format,
        orElse: () => BarcodeFormat.qrCode,
      ),
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      imageUrl: imageUrl,
      colorHex: colorHex,
      notes: notes,
      isArchived: isArchived,
    );
  }
}
