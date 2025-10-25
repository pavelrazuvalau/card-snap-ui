import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'card_strategy_interface.dart';
import 'card_strategy_factory.dart';

/// 🔶 Adaptive Card Factory
///
/// Factory for creating adaptive card widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
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
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = CardStrategyFactory.getStrategy(theme);

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
