/// 🔶 List Tile Strategy Interface
///
/// Defines the contract for creating list tiles across different platforms.
/// Similar to Angular's abstract class that defines common interface.
library presentation.widgets.adaptive.list_tile;

import 'package:flutter/material.dart';

/// 🔶 Base interface for list tile strategy
///
/// Defines the contract for creating list tiles across different platforms.
/// Similar to Angular's abstract class that defines common interface.
abstract class ListTileStrategy {
  Widget createListTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  });
}
