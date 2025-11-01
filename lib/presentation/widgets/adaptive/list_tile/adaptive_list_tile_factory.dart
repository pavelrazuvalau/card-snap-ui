import 'package:flutter/material.dart';
import 'list_tile_strategy_factory.dart';

/// 🔶 Adaptive List Tile Factory
///
/// Factory for creating adaptive list tile widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
class AdaptiveListTileFactory {
  /// Create adaptive list tile based on platform
  /// 🔹 Returns platform-appropriate list tile widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createListTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    final strategy = ListTileStrategyFactory.getStrategy();

    return strategy.createListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      onTap: onTap,
      enabled: enabled,
    );
  }
}
