/// 🔶 Card Strategy Interface
///
/// Defines the contract for creating cards across different platforms.
/// Similar to Angular's strategy interface that different implementations must follow.

import 'package:flutter/material.dart';

/// 🔶 Base interface for card strategy
///
/// Defines the contract for creating cards across different platforms.
abstract class CardStrategy {
  Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  });
}
