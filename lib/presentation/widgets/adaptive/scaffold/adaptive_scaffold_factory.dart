import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'scaffold_strategy_factory.dart';

/// 🔶 Adaptive Scaffold Factory
///
/// Factory for creating adaptive scaffold widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveScaffoldFactory {
  /// Create adaptive scaffold based on platform
  /// 🔹 Returns platform-appropriate scaffold widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = ScaffoldStrategyFactory.getStrategy(theme);

    return strategy.createScaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
