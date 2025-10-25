import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'button_strategy_factory.dart';

/// 🔶 Adaptive Button Factory
///
/// Factory for creating adaptive button widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveButtonFactory {
  /// Create adaptive button based on platform
  /// 🔹 Returns platform-appropriate button widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = ButtonStrategyFactory.getStrategy(theme);

    return strategy.createButton(
      child: child,
      onPressed: onPressed,
      style: style,
      padding: padding,
    );
  }
}
