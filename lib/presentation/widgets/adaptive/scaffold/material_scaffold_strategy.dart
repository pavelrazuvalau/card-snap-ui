/// 🔶 Material Scaffold Strategy
///
/// Creates Material Design scaffolds.
/// Similar to Angular Material Scaffold component.

import 'package:flutter/material.dart';
import 'scaffold_strategy_interface.dart';

/// 🔶 Material Scaffold Strategy
///
/// Creates Material Design scaffolds.
class MaterialScaffoldStrategy implements ScaffoldStrategy {
  @override
  Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
