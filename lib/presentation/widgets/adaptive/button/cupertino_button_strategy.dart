/// 🔶 Cupertino Button Strategy
///
/// Creates iOS-style buttons.
/// Similar to Angular's iOS-specific component implementation.
library presentation.widgets.adaptive.button.cupertino;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button_strategy_interface.dart';

/// iOS Cupertino button strategy implementation
class CupertinoButtonStrategy implements ButtonStrategy {
  @override
  Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }
}
