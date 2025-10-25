/// 🔶 Button Strategy Interface
///
/// Defines the contract for creating buttons across different platforms.
/// Similar to Angular's abstract class that defines common interface.
library presentation.widgets.adaptive.button;

import 'package:flutter/material.dart';

/// 🔶 Base interface for button strategy
///
/// Defines the contract for creating buttons across different platforms.
/// Similar to Angular's abstract class that defines common interface.
abstract class ButtonStrategy {
  Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  });
}
