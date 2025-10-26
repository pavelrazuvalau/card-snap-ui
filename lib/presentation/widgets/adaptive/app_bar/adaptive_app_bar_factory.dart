import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'app_bar_strategy_factory.dart';

/// 🔶 Adaptive App Bar Factory
///
/// Factory for creating adaptive app bar widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveAppBarFactory {
  /// Create adaptive app bar based on platform
  /// 🔹 Returns platform-appropriate app bar widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  }) {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = AppBarStrategyFactory.getStrategy(theme);

    return strategy.createAppBar(
      title: title,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
