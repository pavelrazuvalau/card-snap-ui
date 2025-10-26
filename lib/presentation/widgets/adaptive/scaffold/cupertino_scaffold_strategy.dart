/// 🔶 Cupertino Scaffold Strategy
///
/// Creates iOS-style scaffolds following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/foundations/layout
///
/// iOS HIG specifications applied:
/// - Uses CupertinoPageScaffold for iOS-native layout
/// - Supports CupertinoNavigationBar (iOS HIG navigation pattern)
/// - Background color adapts to light/dark mode automatically
/// - Converts Material AppBar to CupertinoNavigationBar when needed
///
/// Angular analogy: iOS-native page layout with HIG compliance.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'scaffold_strategy_interface.dart';

/// 🔶 Cupertino Scaffold Strategy
///
/// Creates iOS-style scaffolds following Human Interface Guidelines.
/// 🔹 CupertinoPageScaffold provides iOS-native layout structure
/// 🔹 NavigationBar follows iOS HIG navigation patterns
/// 🧠 Automatically converts Material AppBar to CupertinoNavigationBar
class CupertinoScaffoldStrategy implements ScaffoldStrategy {
  @override
  Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    // iOS HIG: CupertinoPageScaffold provides native iOS layout
    // Supports CupertinoNavigationBar for iOS-native navigation
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: appBar != null ? _convertToCupertinoNavBar(appBar) : null,
      child: body,
    );
  }

  /// Convert Material AppBar to CupertinoNavigationBar
  /// 🔹 iOS HIG: Navigation bars use different styling than Material AppBar
  /// 🧠 Converts Material components to iOS-native equivalents
  CupertinoNavigationBar? _convertToCupertinoNavBar(
    PreferredSizeWidget appBar,
  ) {
    if (appBar is AppBar) {
      return CupertinoNavigationBar(
        middle: appBar.title,
        trailing: appBar.actions != null && appBar.actions!.isNotEmpty
            ? Row(mainAxisSize: MainAxisSize.min, children: appBar.actions!)
            : null,
        leading: appBar.leading,
        automaticallyImplyLeading: appBar.automaticallyImplyLeading,
      );
    }
    return null;
  }
}
