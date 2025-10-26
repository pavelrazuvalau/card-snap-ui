/// 🔶 Cupertino Card Strategy
///
/// Creates iOS-style cards following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/content-views/cards
///
/// iOS HIG specifications applied:
/// - Uses Container with BoxDecoration (no Material Card widget)
/// - Border radius: 12pt (iOS standard for cards)
/// - Padding: 16pt (iOS HIG content inset standard)
/// - Shadow: Subtle shadow with 8pt blur, 2pt offset
/// - Color: Uses CupertinoColors.systemBackground for light/dark mode support
///
/// Angular analogy: iOS-style card component with Human Interface Guidelines compliance.

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
    // Vertical margin of 8pt provides proper card spacing
    final cardMargin =
        margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    // iOS HIG: Border radius of 12pt is standard for card components
    // This matches Apple's design system across all iOS apps
    final borderRadius = BorderRadius.circular(12);

    // iOS HIG: Uses systemBackground color for automatic light/dark mode support
    // This ensures cards look proper in both light and dark appearances
    final cardColor = color ?? CupertinoColors.systemBackground;

    // iOS HIG: Subtle shadow replaces Material elevation
    // Uses systemGrey with 0.2 opacity for proper depth perception
    final boxShadow = BoxShadow(
      color: CupertinoColors.systemGrey.withOpacity(0.2),
      blurRadius: 8, // Blur radius matches Material guidelines
      offset: const Offset(0, 2), // Vertical offset for depth
    );

    // iOS HIG: Standard content padding is 16pt
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
