import 'package:flutter/material.dart';
import 'button_strategy_factory.dart';

/// 🔶 Adaptive Button Factory
///
/// Factory for creating adaptive button widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
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
    final strategy = ButtonStrategyFactory.getStrategy();

    return strategy.createButton(
      child: child,
      onPressed: onPressed,
      style: style,
      padding: padding,
    );
  }
}
