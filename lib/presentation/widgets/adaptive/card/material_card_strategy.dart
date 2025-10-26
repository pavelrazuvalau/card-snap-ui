/// 🔶 Material Card Strategy
///
/// Creates Material Design cards following Material Design Guidelines.
/// Reference: https://m3.material.io/components/cards
///
/// Similar to Angular Material Card component with platform-specific adaptations.
///
/// Material Design 3 specifications applied:
/// - Default elevation: 1dp (cards), 3dp (raised cards)
/// - Default padding: 16dp (Material 3 guidelines)
/// - Shape: rounded corners with 12dp radius (Material 3 default)
///
/// Angular analogy: Angular Material Card component with Material Design 3 styling.

import 'package:flutter/material.dart';
import 'card_strategy_interface.dart';

/// 🔶 Material Card Strategy
///
/// Creates Material Design 3 cards with proper elevation, padding, and shape.
/// 🔹 Default padding (16dp) follows Material Design 3 guidelines
/// 🔹 Default elevation (1dp) matches Material Design 3 card specifications
/// 🧠 Padding of 16dp ensures proper content breathing room per Material guidelines
class MaterialCardStrategy implements CardStrategy {
  @override
  Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    // Material Design 3: Default card elevation is 1dp
    // Elevated cards use 3dp for better visual hierarchy
    final cardElevation = elevation ?? 1.0;

    // Material Design 3: Default shape uses rounded corners (12dp radius)
    final cardShape =
        shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

    // Material Design 3: Standard content padding is 16dp
    // This ensures consistent spacing across all card content
    const standardPadding = EdgeInsets.all(16);

    return Card(
      margin: margin,
      color: color,
      elevation: cardElevation,
      shape: cardShape,
      child: Padding(padding: padding ?? standardPadding, child: child),
    );
  }
}
