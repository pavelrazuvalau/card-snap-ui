/// 🔶 Material Scaffold Strategy
///
/// Creates Material Design 3 scaffolds following Material Design Guidelines.
/// Reference: https://m3.material.io/foundations/surfaces
///
/// Material Design 3 specifications applied:
/// - Uses Scaffold as the root container for Material Design apps
/// - Supports AppBar, FAB, BottomNavigationBar (Material 3 components)
/// - Background color adapts to light/dark theme automatically
/// - Provides Material Design 3 spacing and padding defaults
///
/// Angular analogy: Angular Material Scaffold with Material Design 3 compliance.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

import 'package:flutter/material.dart';
import 'scaffold_strategy_interface.dart';

/// 🔶 Material Scaffold Strategy
///
/// Creates Material Design 3 scaffolds with proper component support.
/// 🔹 Scaffold provides Material Design 3 surface structure
/// 🔹 Supports Material 3 components (AppBar, FAB, BottomNavigationBar)
/// 🧠 Background color adapts automatically to light/dark mode
class MaterialScaffoldStrategy implements ScaffoldStrategy {
  @override
  Widget createScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    Widget? bottomNavigationBar,
    Color? backgroundColor,
  }) {
    // Material Design 3: Scaffold is the primary layout structure
    // Provides Material Design 3 surface, spacing, and component support
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: backgroundColor,
    );
  }
}
