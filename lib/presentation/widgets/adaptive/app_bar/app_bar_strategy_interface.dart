/// 🔶 App Bar Strategy Interface
///
/// Defines the contract for creating app bars across different platforms.
/// Similar to Angular's abstract class that defines common interface.
library presentation.widgets.adaptive.app_bar;

import 'package:flutter/material.dart';

/// 🔶 Base interface for app bar strategy
///
/// Defines the contract for creating app bars across different platforms.
/// Similar to Angular's abstract class that defines common interface.
abstract class AppBarStrategy {
  Widget createAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  });
}
