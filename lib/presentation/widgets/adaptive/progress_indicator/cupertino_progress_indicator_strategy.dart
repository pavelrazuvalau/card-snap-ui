/// 🔶 Cupertino Progress Indicator Strategy
///
/// Creates iOS-style progress indicators following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/system-experiences/activity-indicators
///
/// iOS Human Interface Guidelines specifications applied:
/// - Uses CupertinoActivityIndicator for loading states
/// - Uses system blue color
/// - Different animation style from Material
///
/// Key differences from Material:
/// - iOS uses different animation timing and appearance
/// - Different color scheme (system colors vs theme colors)
/// - Different visual style per iOS HIG
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom loading spinner that adapts to platform conventions.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.progress_indicator.cupertino;

import 'package:flutter/cupertino.dart';
import 'progress_indicator_strategy_interface.dart';

/// Cupertino (iOS) progress indicator strategy implementation
/// 🔹 CupertinoActivityIndicator follows iOS Human Interface Guidelines
/// 🔹 Uses system blue color
/// 🧠 Different animation style from Material
class CupertinoProgressIndicatorStrategy implements ProgressIndicatorStrategy {
  @override
  Widget createProgressIndicator() {
    // iOS HIG: CupertinoActivityIndicator uses iOS-native animation
    return const CupertinoActivityIndicator();
  }
}
