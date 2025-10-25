/// 🔶 Adaptive Widget Module - Main Facade
///
/// Main facade that provides convenient access to all adaptive widgets.
/// Similar to Angular's SharedModule that exports all common components
/// and services for easy importing.
///
/// This module provides platform-agnostic UI components that adapt to different
/// platforms (Android Material, iOS Cupertino, Web) while maintaining consistent
/// behavior and appearance.
library presentation.widgets.adaptive;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Import common types
import 'common/platform_types.dart';

// Import factories
import 'scaffold/adaptive_scaffold_factory.dart';
import 'card/adaptive_card_factory.dart';
import 'button/adaptive_button_factory.dart';

// Export common types and selectors
export 'common/platform_types.dart';
export 'common/strategy_selector.dart';

// Export factories
export 'scaffold/adaptive_scaffold_factory.dart';
export 'card/adaptive_card_factory.dart';
export 'button/adaptive_button_factory.dart';

// Export strategies - all components now use separate files for flexibility
export 'scaffold/scaffold_strategy_interface.dart';
export 'scaffold/material_scaffold_strategy.dart';
export 'scaffold/cupertino_scaffold_strategy.dart';
export 'scaffold/scaffold_strategy_factory.dart';

export 'card/card_strategy_interface.dart';
export 'card/material_card_strategy.dart';
export 'card/cupertino_card_strategy.dart';
export 'card/card_strategy_factory.dart';

export 'button/button_strategy_interface.dart';
export 'button/material_button_strategy.dart';
export 'button/cupertino_button_strategy.dart';
export 'button/button_strategy_factory.dart';

// All widget components now follow flexibility-first approach with separate files

/// 🔶 Adaptive Widget Factory - Main Facade
///
/// Main factory class that provides convenient access to all adaptive widgets.
/// Similar to Angular's component factory that creates different
/// implementations based on the target platform.
class AdaptiveWidgetFactory {
  /// Get the current platform theme
  /// 🔹 Determines UI theme based on platform detection
  /// 🧠 Web platform uses Material by default but can be customized
  static PlatformTheme getCurrentTheme() {
    return PlatformDetector.getCurrentTheme();
  }

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
    return AdaptiveScaffoldFactory.createScaffold(
      body: body,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }

  /// Create adaptive app bar based on platform
  /// 🔹 Returns platform-appropriate app bar widget
  /// 🧠 iOS uses CupertinoNavigationBar with different styling
  static Widget createAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  }) {
    final theme = getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoNavigationBar(
          middle: Text(title),
          trailing: actions != null && actions.isNotEmpty
              ? Row(mainAxisSize: MainAxisSize.min, children: actions)
              : null,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return AppBar(
          title: Text(title),
          actions: actions,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
        );
    }
  }

  /// Create adaptive card widget based on platform
  /// 🔹 Returns platform-appropriate card widget
  /// 🧠 iOS uses CupertinoCard with different styling and behavior
  static Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    return AdaptiveCardFactory.createCard(
      child: child,
      margin: margin,
      padding: padding,
      color: color,
      elevation: elevation,
      shape: shape,
    );
  }

  /// Create adaptive list tile based on platform
  /// 🔹 Returns platform-appropriate list tile widget
  /// 🧠 iOS uses CupertinoListTile with different interaction patterns
  static Widget createListTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    final theme = getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoListTile(
          leading: leading,
          title: title ?? const SizedBox.shrink(),
          subtitle: subtitle,
          trailing: trailing,
          onTap: enabled ? onTap : null,
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          onTap: enabled ? onTap : null,
          enabled: enabled,
        );
    }
  }

  /// Create adaptive button based on platform
  /// 🔹 Returns platform-appropriate button widget
  /// 🧠 iOS uses CupertinoButton with different styling and press effects
  static Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    return AdaptiveButtonFactory.createButton(
      child: child,
      onPressed: onPressed,
      style: style,
      padding: padding,
    );
  }

  /// Create adaptive progress indicator based on platform
  /// 🔹 Returns platform-appropriate progress indicator
  /// 🧠 iOS uses CupertinoActivityIndicator with different animation
  static Widget createProgressIndicator() {
    final theme = getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return const CupertinoActivityIndicator();
      case PlatformTheme.material:
      case PlatformTheme.web:
        return const CircularProgressIndicator();
    }
  }

  /// Create adaptive dialog based on platform
  /// 🔹 Returns platform-appropriate dialog widget
  /// 🧠 iOS uses CupertinoAlertDialog with different styling
  static Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    final theme = getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions,
        );
    }
  }
}

/// 🔶 Adaptive Theme Configuration
///
/// Centralized theme configuration that adapts to different platforms.
/// Similar to Angular's theme service that provides platform-specific
/// styling configurations.
class AdaptiveThemeConfig {
  /// Get platform-appropriate primary color
  /// 🔹 Returns platform-specific primary colors
  /// 🧠 iOS uses system blue, Material uses theme primary color
  static Color getPrimaryColor(BuildContext context) {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoColors.systemBlue;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Theme.of(context).primaryColor;
    }
  }

  /// Get platform-appropriate text theme
  /// 🔹 Returns platform-specific text styles
  /// 🧠 iOS uses Cupertino text styles, Material uses Material text styles
  static TextTheme getTextTheme(BuildContext context) {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return Theme.of(context).textTheme; // Use Material text theme for now
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Theme.of(context).textTheme;
    }
  }

  /// Get platform-appropriate icon theme
  /// 🔹 Returns platform-specific icon styles
  /// 🧠 iOS uses Cupertino icons, Material uses Material icons
  static IconThemeData getIconTheme(BuildContext context) {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return const CupertinoIconThemeData();
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Theme.of(context).iconTheme;
    }
  }
}
