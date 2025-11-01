import 'package:flutter/material.dart';
import 'app_bar_strategy_factory.dart';

/// 🔶 Adaptive App Bar Factory
///
/// Factory for creating adaptive app bar widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
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
    final strategy = AppBarStrategyFactory.getStrategy();

    return strategy.createAppBar(
      title: title,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
