import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'dialog_strategy_factory.dart';

/// 🔶 Adaptive Dialog Factory
///
/// Factory for creating adaptive dialog widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveDialogFactory {
  /// Create adaptive dialog based on platform
  /// 🔹 Returns platform-appropriate dialog widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = DialogStrategyFactory.getStrategy(theme);

    return strategy.createDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
