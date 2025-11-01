/// 🔶 Cupertino Card Strategy
///
/// Creates iOS-style cards following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/content-views/cards
/// Visual Design: https://developer.apple.com/design/human-interface-guidelines/visual-design
///
/// iOS HIG specifications applied:
/// - Uses Container with BoxDecoration (no Material Card widget)
/// - Border radius: 12pt (iOS standard for cards)
///   Reference: iOS HIG visual design - rounded corners standard
/// - Padding: 16pt (iOS HIG content inset standard)
///   Reference: iOS HIG layout - content inset guidelines
/// - Shadow: Subtle shadow with 8pt blur, 2pt offset
///   Reference: iOS HIG visual design - depth and elevation via shadows
/// - Color: Uses CupertinoColors.systemBackground for light/dark mode support
///   Reference: iOS HIG color - adaptive colors for light/dark appearances
///
/// Angular analogy: iOS-style card component with Human Interface Guidelines compliance.
///
/// See STYLEGUIDE.md#72-ios-human-interface-guidelines-hig (§7.2) for iOS Human Interface Guidelines compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

import 'package:flutter/cupertino.dart';
import 'card_strategy_interface.dart';

/// 🔶 Cupertino Card Strategy
///
/// Creates iOS-style cards following Human Interface Guidelines.
/// 🔹 Border radius (12pt) matches iOS HIG card specifications
/// 🔹 Padding (16pt) follows iOS HIG content inset guidelines
/// 🔹 Shadow uses systemGrey with 0.2 opacity for subtle elevation
/// 🧠 iOS doesn't use Material elevation - uses shadows instead
class CupertinoCardStrategy implements CardStrategy {
  @override
  Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    // iOS HIG: Standard horizontal margin is 16pt for content
    // Reference: https://developer.apple.com/design/human-interface-guidelines/layout
    // Vertical margin of 8pt provides proper card spacing per iOS spacing guidelines
    final cardMargin =
        margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    // iOS HIG: Border radius of 12pt is standard for card components
    // Reference: https://developer.apple.com/design/human-interface-guidelines/visual-design/corners
    // This matches Apple's design system across all iOS apps for consistent card appearance
    final borderRadius = BorderRadius.circular(12);

    // iOS HIG: Uses systemBackground color for automatic light/dark mode support
    // Reference: https://developer.apple.com/design/human-interface-guidelines/color
    // This ensures cards look proper in both light and dark appearances using adaptive colors
    final cardColor = color ?? CupertinoColors.systemBackground;

    // iOS HIG: Subtle shadow replaces Material elevation
    // Reference: https://developer.apple.com/design/human-interface-guidelines/visual-design/depth
    // iOS uses shadows (not Material elevation) with 8pt blur and 2pt offset for depth
    final boxShadow = BoxShadow(
      color: CupertinoColors.systemGrey.withOpacity(0.2),
      blurRadius: 8, // 8pt blur matches iOS shadow guidelines for subtle depth
      offset: const Offset(
        0,
        2,
      ), // 2pt vertical offset provides proper elevation perception
    );

    // iOS HIG: Standard content padding is 16pt
    // Reference: https://developer.apple.com/design/human-interface-guidelines/layout
    // 16pt ensures proper content inset matching iOS HIG spacing standards
    const standardPadding = EdgeInsets.all(16);

    return Container(
      margin: cardMargin,
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: borderRadius,
        boxShadow: [boxShadow],
      ),
      child: Padding(padding: padding ?? standardPadding, child: child),
    );
  }
}
