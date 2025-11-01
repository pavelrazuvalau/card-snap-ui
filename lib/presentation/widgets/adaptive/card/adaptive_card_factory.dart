import 'package:flutter/material.dart';
import 'card_strategy_factory.dart';

/// 🔶 Adaptive Card Factory
///
/// Factory for creating adaptive card widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
class AdaptiveCardFactory {
  /// Create adaptive card widget based on platform
  /// 🔹 Returns platform-appropriate card widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    final strategy = CardStrategyFactory.getStrategy();

    return strategy.createCard(
      child: child,
      margin: margin,
      padding: padding,
      color: color,
      elevation: elevation,
      shape: shape,
    );
  }
}
