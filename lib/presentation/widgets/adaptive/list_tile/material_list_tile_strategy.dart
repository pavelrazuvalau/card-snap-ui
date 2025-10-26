/// 🔶 Material List Tile Strategy
///
/// Creates Material Design 3 list tiles following Material Design Guidelines.
/// Reference: https://m3.material.io/components/lists
///
/// Material Design 3 specifications applied:
/// - Uses ListTile widget for list items
/// - Default height: 56dp (standard Material list tile height)
/// - Support for leading, title, subtitle, and trailing widgets
/// - Disabled state with reduced opacity
///
/// Angular analogy: Angular Material List Item component with Material Design 3 styling.

library presentation.widgets.adaptive.list_tile.material;

import 'package:flutter/material.dart';
import 'list_tile_strategy_interface.dart';

/// Material Design 3 list tile strategy implementation
/// 🔹 ListTile follows Material Design 3 specifications
/// 🔹 Default height: 56dp (standard Material list tile)
/// 🧠 List tile can be customized via theme
class MaterialListTileStrategy implements ListTileStrategy {
  @override
  Widget createListTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    // Material Design 3: ListTile uses standard Material elevation and styling
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
