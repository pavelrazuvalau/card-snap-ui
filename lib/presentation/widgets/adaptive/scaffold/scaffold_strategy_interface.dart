/// 🔶 Scaffold Strategy Interface
///
/// Defines the contract for creating scaffolds across different platforms.
/// Similar to Angular's strategy interface that different implementations must follow.

import 'package:flutter/material.dart';

/// 🔶 Base interface for scaffold strategy
///
/// Defines the contract for creating scaffolds across different platforms.
abstract class ScaffoldStrategy {
  Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  });
}
