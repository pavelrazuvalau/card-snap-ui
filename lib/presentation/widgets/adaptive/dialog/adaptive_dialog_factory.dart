import 'package:flutter/material.dart';
import 'dialog_strategy_factory.dart';

/// 🔶 Adaptive Dialog Factory
///
/// Factory for creating adaptive dialog widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
class AdaptiveDialogFactory {
  /// Create adaptive dialog based on platform
  /// 🔹 Returns platform-appropriate dialog widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    final strategy = DialogStrategyFactory.getStrategy();

    return strategy.createDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
