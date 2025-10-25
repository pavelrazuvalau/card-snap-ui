/// 🔶 Material Card Strategy
///
/// Creates Material Design cards.
/// Similar to Angular Material Card component.

import 'package:flutter/material.dart';
import 'card_strategy_interface.dart';

/// 🔶 Material Card Strategy
///
/// Creates Material Design cards.
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
    return Card(
      margin: margin,
      color: color,
      elevation: elevation,
      shape: shape,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}
