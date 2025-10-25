/// 🔶 Adaptive Button Widget
///
/// Platform-adaptive button implementation that provides different
/// button styles based on the current platform.
///
/// Similar to Angular's button components that adapt to different
/// design systems (Material, Cupertino).
library presentation.widgets.adaptive.button;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../common/platform_types.dart';

/// 🔶 Adaptive Button Factory
///
/// Factory for creating adaptive button widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveButtonFactory {
  /// Create adaptive button based on platform
  /// 🔹 Returns platform-appropriate button widget
  /// 🧠 iOS uses CupertinoButton with different styling and press effects
  static Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = PlatformDetector.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoButton(
          onPressed: onPressed,
          padding: padding,
          child: child,
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return ElevatedButton(
          onPressed: onPressed,
          style: style,
          child: child,
        );
    }
  }
}
