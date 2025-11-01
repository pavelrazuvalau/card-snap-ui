/// 🔶 Cupertino Button Strategy
///
/// Creates iOS-style buttons following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/buttons
///
/// iOS HIG specifications applied:
/// - Uses CupertinoButton for iOS-native appearance
/// - Default minimum touch target: 44pt × 44pt (iOS HIG requirement)
/// - Default padding: 16pt (iOS HIG button content inset)
/// - Supports light/dark mode automatically via CupertinoColors
/// - Ripple effect uses Cupertino ripple animation
///
/// Angular analogy: iOS-native button component with HIG compliance.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.button.cupertino;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button_strategy_interface.dart';

/// iOS Cupertino button strategy implementation
/// 🔹 CupertinoButton follows iOS HIG specifications
/// 🔹 Minimum touch target: 44pt × 44pt (iOS HIG accessibility requirement)
/// 🧠 Supports light/dark mode automatically
class CupertinoButtonStrategy implements ButtonStrategy {
  @override
  Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    // iOS HIG: CupertinoButton provides iOS-native button appearance
    // Includes proper ripple effects and touch feedback
    // Automatically adapts to light/dark mode via CupertinoColors
    return CupertinoButton(
      onPressed: onPressed,
      padding: padding,
      child: child,
    );
  }
}
