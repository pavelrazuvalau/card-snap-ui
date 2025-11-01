/// 🔶 Material Card Strategy
///
/// Creates Material Design cards following Material Design Guidelines.
/// Reference: https://m3.material.io/components/cards
/// Specs: https://m3.material.io/components/cards/specs
/// Elevation: https://m3.material.io/styles/elevation/tokens
///
/// Similar to Angular Material Card component with platform-specific adaptations.
///
/// Material Design 3 specifications applied:
/// - Default elevation: 1dp (cards), 3dp (raised cards)
///   Reference: M3 Elevation token "level 1" for cards
/// - Default padding: 16dp (Material 3 guidelines)
///   Reference: M3 spacing system - standard content padding
/// - Shape: rounded corners with 12dp radius (Material 3 default)
///   Reference: M3 shape system - card corner radius
///
/// Angular analogy: Angular Material Card component with Material Design 3 styling.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

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
    // Reference: https://m3.material.io/styles/elevation/tokens
    // Elevated cards use 3dp for better visual hierarchy
    // This follows M3 elevation system "level 1" for default cards
    final cardElevation = elevation ?? 1.0;

    // Material Design 3: Default shape uses rounded corners (12dp radius)
    // Reference: https://m3.material.io/styles/shape/shape-scale-tokens
    // 12dp radius ensures cards have subtle rounded corners per M3 guidelines
    final cardShape =
        shape ??
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

    // Material Design 3: Standard content padding is 16dp
    // Reference: https://m3.material.io/design/layout/spacing-methods.html
    // 16dp ensures proper content breathing room per Material spacing system
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
