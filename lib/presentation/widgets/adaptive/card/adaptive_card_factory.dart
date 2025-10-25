/// 🔶 Adaptive Card Widget
///
/// Platform-adaptive card implementation that provides different
/// card styles based on the current platform.
///
/// Similar to Angular's card components that adapt to different
/// design systems (Material, Cupertino).
library presentation.widgets.adaptive.card;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../common/platform_types.dart';

/// 🔶 Adaptive Card Factory
///
/// Factory for creating adaptive card widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveCardFactory {
  /// Create adaptive card widget based on platform
  /// 🔹 Returns platform-appropriate card widget
  /// 🧠 iOS uses CupertinoCard with different styling and behavior
  static Widget createCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    Color? color,
    double? elevation,
    ShapeBorder? shape,
  }) {
    final theme = PlatformDetector.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return Container(
          margin: margin ?? 
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: color ?? CupertinoColors.systemBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.systemGrey.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Card(
          margin: margin,
          color: color,
          elevation: elevation,
          shape: shape,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        );
    }
  }
}
