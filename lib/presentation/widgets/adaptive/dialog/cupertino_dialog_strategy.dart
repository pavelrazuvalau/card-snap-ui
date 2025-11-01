/// 🔶 Cupertino Dialog Strategy
///
/// Creates iOS-style dialogs following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/alerts
///
/// iOS Human Interface Guidelines specifications applied:
/// - Uses CupertinoAlertDialog for modal alerts
/// - No elevation (iOS alerts are modal overlays)
/// - Different styling and layout from Material
///
/// Key differences from Material:
/// - iOS uses different layout (compact, centered)
/// - Different button styling and placement
/// - No border radius on the dialog itself (iOS uses system alerts)
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom alert component that adapts to platform conventions.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.dialog.cupertino;

import 'package:flutter/cupertino.dart';
import 'dialog_strategy_interface.dart';

/// Cupertino (iOS) dialog strategy implementation
/// 🔹 CupertinoAlertDialog follows iOS Human Interface Guidelines
/// 🔹 No elevation (iOS alerts are modal overlays)
/// 🧠 Different styling and layout from Material
class CupertinoDialogStrategy implements DialogStrategy {
  @override
  Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    // iOS HIG: CupertinoAlertDialog uses iOS-native alert styling
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}
