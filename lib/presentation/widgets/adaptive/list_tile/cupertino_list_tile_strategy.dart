/// 🔶 Cupertino List Tile Strategy
///
/// Creates iOS-style list tiles following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/content-views/lists
///
/// iOS Human Interface Guidelines specifications applied:
/// - Uses CupertinoListTile for iOS-native list items
/// - No elevation (iOS lists use translucent cells)
/// - Supports leading, title, subtitle, and trailing widgets
/// - Different interaction patterns from Material
///
/// Key differences from Material:
/// - iOS uses translucent cells with separator lines instead of solid elevation
/// - Touch interaction patterns differ per iOS HIG
/// - Different text styling and spacing per iOS HIG
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom list item component that adapts to platform conventions.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.list_tile.cupertino;

import 'package:flutter/cupertino.dart';
import 'list_tile_strategy_interface.dart';

/// Cupertino (iOS) list tile strategy implementation
/// 🔹 CupertinoListTile follows iOS Human Interface Guidelines
/// 🔹 No elevation (iOS uses translucent cells with separator lines)
/// 🧠 Different interaction patterns from Material list tiles
class CupertinoListTileStrategy implements ListTileStrategy {
  @override
  Widget createListTile({
    Widget? leading,
    Widget? title,
    Widget? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    // iOS HIG: List tiles use translucent cells with separator lines
    return CupertinoListTile(
      leading: leading,
      title: title ?? const SizedBox.shrink(),
      subtitle: subtitle,
      trailing: trailing,
      onTap: enabled ? onTap : null,
    );
  }
}
