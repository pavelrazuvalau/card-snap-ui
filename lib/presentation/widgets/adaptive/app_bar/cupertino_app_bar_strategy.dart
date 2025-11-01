/// 🔶 Cupertino App Bar Strategy
///
/// Creates iOS-style navigation bars following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/navigation-and-search/navigation-bars
///
/// iOS Human Interface Guidelines specifications applied:
/// - Uses CupertinoNavigationBar for iOS-native navigation
/// - No elevation (iOS uses translucent bars with blur)
/// - Supports middle, leading, and trailing widgets
/// - Automatically implies leading based on navigation context
///
/// Key differences from Material:
/// - iOS uses translucent bars with blur effect instead of solid elevation
/// - Trailing (instead of actions) aligns with iOS conventions
/// - Different text styling and spacing per iOS HIG
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom navigation header that adapts to platform conventions.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.app_bar.cupertino;

import 'package:flutter/cupertino.dart';
import 'app_bar_strategy_interface.dart';

/// Cupertino (iOS) app bar strategy implementation
/// 🔹 CupertinoNavigationBar follows iOS Human Interface Guidelines
/// 🔹 No elevation (iOS uses translucent bars with blur)
/// 🧠 Translucent blur effect provides depth without Material elevation
class CupertinoAppBarStrategy implements AppBarStrategy {
  @override
  Widget createAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool automaticallyImplyLeading = true,
  }) {
    // iOS HIG: Navigation bars are translucent with blur, not solid with elevation
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: actions != null && actions.isNotEmpty
          ? Row(mainAxisSize: MainAxisSize.min, children: actions)
          : null,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
