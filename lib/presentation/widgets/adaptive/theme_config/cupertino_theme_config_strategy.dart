/// 🔶 Cupertino Theme Configuration Strategy
///
/// Provides iOS-style theme configuration.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/color
///
/// iOS Human Interface Guidelines theme configuration applied:
/// - Uses CupertinoColors.systemBlue for primary color
/// - Uses Material text theme (compatibility)
/// - Uses CupertinoIconThemeData for icons
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom theme service that adapts to platform conventions.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.theme_config.cupertino;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'theme_config_strategy_interface.dart';

/// Cupertino (iOS) theme configuration strategy implementation
/// 🔹 Uses iOS system colors for primary color
/// 🔹 Follows iOS Human Interface Guidelines
class CupertinoThemeConfigStrategy implements ThemeConfigStrategy {
  @override
  Color getPrimaryColor(BuildContext context) {
    return CupertinoColors.systemBlue;
  }

  @override
  TextTheme getTextTheme(BuildContext context) {
    // 🧠 Use Material text theme for compatibility (can be enhanced with Cupertino text in future)
    return Theme.of(context).textTheme;
  }

  @override
  IconThemeData getIconTheme(BuildContext context) {
    return const CupertinoIconThemeData();
  }
}
