/// 🔶 Cupertino Icon Strategy
///
/// Provides iOS-style icons and colors.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/icons
///
/// iOS Human Interface Guidelines specifications applied:
/// - Uses Cupertino Icons for iOS-native look
/// - Uses CupertinoColors for system colors
///
/// Angular analogy: iOS-native icon service.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.icon_strategy.cupertino;

import 'package:flutter/cupertino.dart'
    show Color, CupertinoColors, CupertinoIcons, IconData;
import 'icon_strategy_interface.dart';

/// Cupertino (iOS) icon strategy implementation
/// 🔹 Uses Cupertino Icons
/// 🔹 Uses CupertinoColors
class CupertinoIconStrategy implements IconStrategy {
  @override
  IconData getCreditCardIcon() => CupertinoIcons.creditcard;

  @override
  IconData getOfflineIcon() => CupertinoIcons.wifi_slash;

  @override
  Color getSubtitleColor() => CupertinoColors.systemGrey;
}
