/// 🔶 Adaptive Scaffold Widget
///
/// Platform-adaptive scaffold implementation that provides different
/// scaffold types based on the current platform.
///
/// Similar to Angular's layout components that adapt to different
/// screen sizes and platforms.
library presentation.widgets.adaptive.scaffold;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../common/platform_types.dart';

/// 🔶 Adaptive Scaffold Factory
///
/// Factory for creating adaptive scaffold widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveScaffoldFactory {
  /// Create adaptive scaffold based on platform
  /// 🔹 Returns platform-appropriate scaffold widget
  /// 🧠 iOS uses CupertinoPageScaffold, others use Material Scaffold
  static Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    final theme = PlatformDetector.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoPageScaffold(
          navigationBar: appBar != null
              ? _convertToCupertinoNavBar(appBar)
              : null,
          child: body,
          backgroundColor: backgroundColor,
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Scaffold(
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          backgroundColor: backgroundColor,
        );
    }
  }

  /// Convert Material AppBar to CupertinoNavigationBar
  /// 🔹 Helper method for scaffold conversion
  /// 🧠 Handles the differences between Material and Cupertino navigation
  static CupertinoNavigationBar? _convertToCupertinoNavBar(
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
