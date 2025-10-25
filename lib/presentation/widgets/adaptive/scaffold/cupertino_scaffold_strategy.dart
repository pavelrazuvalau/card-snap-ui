/// 🔶 Cupertino Scaffold Strategy
///
/// Creates iOS-style scaffolds.
/// Similar to iOS PageScaffold component.

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'scaffold_strategy_interface.dart';

/// 🔶 Cupertino Scaffold Strategy
///
/// Creates iOS-style scaffolds.
class CupertinoScaffoldStrategy implements ScaffoldStrategy {
  @override
  Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    return CupertinoPageScaffold(
      backgroundColor: backgroundColor,
      navigationBar: appBar != null ? _convertToCupertinoNavBar(appBar) : null,
      child: body,
    );
  }

  /// Convert Material AppBar to CupertinoNavigationBar
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
