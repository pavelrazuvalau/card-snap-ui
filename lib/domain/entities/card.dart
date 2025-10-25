/// 🔶 Domain Entity: LoyaltyCard
///
/// Core business model representing a loyalty/discount card.
/// Similar to Angular's domain models but pure Dart (no framework dependencies).
///
/// In Angular, you'd have:
/// ```typescript
/// export interface Card {
///   id: string;
///   name: string;
///   barcode: string;
///   storeName: string;
///   createdAt: Date;
/// }
/// ```
///
/// In Flutter/Dart, we use immutable classes with value semantics.
library domain.entities;

/// Loyalty/discount card entity
/// 🔹 Simple immutable class for minimal startup
/// 🔹 Pure Dart - no Flutter imports (domain layer principle)
class LoyaltyCard {
  /// Unique identifier for the card
  final String id;

  /// User-friendly name for the card
  final String name;

  /// Store or brand name
  final String storeName;

  /// Barcode/QR code data
  final String barcodeData;

  /// Barcode format (QR, Code128, EAN13, etc.)
  final BarcodeFormat format;

  /// Card creation timestamp
  final DateTime createdAt;

  /// Last modification timestamp
  final DateTime updatedAt;

  /// Optional card image/logo URL
  final String? imageUrl;

  /// Optional card color for UI theming
  final String? colorHex;

  /// Optional notes from user
  final String? notes;

  /// Whether card is archived (soft delete)
  final bool isArchived;

  const LoyaltyCard({
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

  /// Create a copy with updated fields
  /// 🔹 Immutable update pattern
  LoyaltyCard copyWith({
    String? id,
    String? name,
    String? storeName,
    String? barcodeData,
    BarcodeFormat? format,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? imageUrl,
    String? colorHex,
    String? notes,
    bool? isArchived,
  }) {
    return LoyaltyCard(
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

  /// Convert to JSON map
  /// 🔹 Simple serialization for data persistence
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'storeName': storeName,
      'barcodeData': barcodeData,
      'format': format.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'imageUrl': imageUrl,
      'colorHex': colorHex,
      'notes': notes,
      'isArchived': isArchived,
    };
  }

  /// Create from JSON map
  /// 🔹 Simple deserialization from data persistence
  factory LoyaltyCard.fromJson(Map<String, dynamic> json) {
    return LoyaltyCard(
      id: json['id'] as String,
      name: json['name'] as String,
      storeName: json['storeName'] as String,
      barcodeData: json['barcodeData'] as String,
      format: BarcodeFormat.values.firstWhere(
        (f) => f.name == json['format'],
        orElse: () => BarcodeFormat.qrCode,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      imageUrl: json['imageUrl'] as String?,
      colorHex: json['colorHex'] as String?,
      notes: json['notes'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoyaltyCard &&
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
    return 'LoyaltyCard(id: $id, name: $name, storeName: $storeName)';
  }
}

/// Supported barcode formats
/// 🔹 Enum for type safety (like TypeScript string literals)
enum BarcodeFormat {
  /// QR Code (2D matrix)
  qrCode,

  /// Code 128 (1D linear)
  code128,

  /// EAN-13 (European Article Number)
  ean13,

  /// UPC-A (Universal Product Code)
  upcA,

  /// Code 39 (1D linear)
  code39,

  /// PDF417 (2D stacked)
  pdf417,
}

/// Card validation rules
/// 🔹 Business logic for card validation
extension LoyaltyCardValidation on LoyaltyCard {
  /// Validate card data integrity
  /// 🧠 Business rule: cards must have valid barcode data
  bool get isValid {
    if (name.trim().isEmpty) return false;
    if (storeName.trim().isEmpty) return false;
    if (barcodeData.trim().isEmpty) return false;
    if (createdAt.isAfter(DateTime.now())) return false;
    if (updatedAt.isBefore(createdAt)) return false;
    return true;
  }

  /// Get display-friendly format name
  /// 🔹 UI helper method (domain layer can have pure UI helpers)
  String get formatDisplayName {
    switch (format) {
      case BarcodeFormat.qrCode:
        return 'QR Code';
      case BarcodeFormat.code128:
        return 'Code 128';
      case BarcodeFormat.ean13:
        return 'EAN-13';
      case BarcodeFormat.upcA:
        return 'UPC-A';
      case BarcodeFormat.code39:
        return 'Code 39';
      case BarcodeFormat.pdf417:
        return 'PDF417';
    }
  }
}
