/// 🔶 Material Button Strategy
///
/// Creates Material Design buttons.
/// Similar to Angular's Material component implementation.
library presentation.widgets.adaptive.button.material;

import 'package:flutter/material.dart';
import 'button_strategy_interface.dart';

/// Material Design button strategy implementation
class MaterialButtonStrategy implements ButtonStrategy {
  @override
  Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    return ElevatedButton(onPressed: onPressed, style: style, child: child);
  }
}
