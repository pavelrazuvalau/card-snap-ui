/// 🔶 Dialog Strategy Interface
///
/// Defines the contract for creating dialogs across different platforms.
/// Similar to Angular's abstract class that defines common interface.
library presentation.widgets.adaptive.dialog;

import 'package:flutter/material.dart';

/// 🔶 Base interface for dialog strategy
///
/// Defines the contract for creating dialogs across different platforms.
/// Similar to Angular's abstract class that defines common interface.
abstract class DialogStrategy {
  Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  });
}
