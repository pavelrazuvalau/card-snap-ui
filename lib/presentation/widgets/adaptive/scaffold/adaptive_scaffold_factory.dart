import 'package:flutter/material.dart';
import 'scaffold_strategy_factory.dart';

/// 🔶 Adaptive Scaffold Factory
///
/// Factory for creating adaptive scaffold widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
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
    final strategy = ScaffoldStrategyFactory.getStrategy();

    return strategy.createScaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
