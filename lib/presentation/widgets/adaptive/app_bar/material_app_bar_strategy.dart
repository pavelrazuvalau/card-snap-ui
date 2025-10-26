/// 🔶 Material App Bar Strategy
///
/// Creates Material Design 3 app bars following Material Design Guidelines.
/// Reference: https://m3.material.io/components/app-bars/top
///
/// Material Design 3 specifications applied:
/// - Uses AppBar widget for top navigation
/// - Default height: 56dp (standard Material app bar height)
/// - Uses theme's surface color
/// - Support for leading, title, and actions
///
/// Angular analogy: Angular Material Toolbar component with Material Design 3 styling.

library presentation.widgets.adaptive.app_bar.material;

import 'package:flutter/material.dart';
import 'app_bar_strategy_interface.dart';

/// Material Design 3 app bar strategy implementation
/// 🔹 AppBar follows Material Design 3 specifications
/// 🔹 Default height: 56dp (standard Material app bar)
/// 🧠 App bar style can be customized via theme
class MaterialAppBarStrategy implements AppBarStrategy {
  @override
  Widget createAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  }) {
    // Material Design 3: AppBar uses standard Material elevation and styling
    return AppBar(
      title: Text(title),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
