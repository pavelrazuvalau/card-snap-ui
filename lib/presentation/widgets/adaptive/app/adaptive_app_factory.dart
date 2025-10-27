/// 🔶 Adaptive App Factory
///
/// Creates platform-appropriate root app widget.
/// Similar to Angular's app component factory that creates platform-specific root components.
///
/// 🧠 Uses Strategy pattern to encapsulate platform-specific app initialization.
library presentation.widgets.adaptive.app;

import 'package:flutter/material.dart';
import 'app_strategy_factory.dart';

/// 🔶 Adaptive App Factory
///
/// Creates platform-appropriate root app widget.
/// Similar to Angular's app component factory that creates platform-specific root components.
///
/// 🧠 Delegates theme creation to strategies for consistent API.
/// Both strategies receive same parameters, but decide internally what to use.
class AdaptiveAppFactory {
  /// Create adaptive app widget based on platform
  /// 🔹 Returns platform-appropriate root app widget
  /// 🧠 iOS uses CupertinoApp (via MaterialApp with Cupertino theme),
  /// Material platforms use MaterialApp
  ///
  /// **Note:** Themes are fully encapsulated in strategies.
  /// No need to pass theme builders - strategies create their own.
  static Widget createApp({
    required String title,
    required Widget home,
    Map<String, WidgetBuilder>? routes,
  }) {
    final strategy = AppStrategyFactory.getStrategy();

    // 🔶 Delegate to strategy
    // 🧠 Strategy creates its own theme internally
    return strategy.buildApp(title: title, home: home, routes: routes);
  }
}
