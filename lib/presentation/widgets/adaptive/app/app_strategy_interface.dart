/// 🔶 App Strategy Interface
///
/// Defines the contract for root app widget strategies across different platforms.
/// Similar to Angular's main app component that wraps the entire application.
///
/// In Flutter, the root app widget is responsible for:
/// - Setting up theme configuration
/// - Providing routing mechanisms
/// - Establishing global app context
library presentation.widgets.adaptive.app;

import 'package:flutter/material.dart';

/// 🔶 Base interface for app strategy
///
/// Defines the contract for creating platform-specific root app widgets.
/// Each platform strategy returns the appropriate app widget (MaterialApp or CupertinoApp).
abstract class AppStrategy {
  /// Build the root app widget
  /// 🔹 Returns platform-appropriate app widget
  /// 🧠 Material platform returns MaterialApp, iOS returns CupertinoApp
  ///
  /// **Note:** Strategy creates its own theme internally - no external theme needed
  Widget buildApp({
    required String title,
    required Widget home,
    Map<String, WidgetBuilder>? routes,
  });
}
