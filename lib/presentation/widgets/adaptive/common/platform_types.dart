/// 🔶 Common Types for Adaptive Widgets
///
/// Shared types and utilities used across all adaptive widget implementations.
/// Similar to Angular's shared types that are used across different modules.
///
/// See STYLEGUIDE.md#44-shared-utilities (§4.4) (Shared Utilities) for organization guidelines
/// and STYLEGUIDE.md#22-dart-syntax-explained-with-angulartypescript-analogies (§2.2) for enum patterns in Dart.
library presentation.widgets.adaptive.common;

import 'dart:io' show Platform;

/// 🔶 Platform Theme Detection
///
/// Determines which UI theme to use based on the current platform.
/// Similar to Angular's platform detection service that adapts behavior
/// based on the runtime environment.
enum PlatformTheme {
  /// Material Design theme (Android, Web)
  material,

  /// Cupertino theme (iOS)
  cupertino,

  /// Web-specific theme adaptations
  web,
}

/// 🔶 Platform detection utility
///
/// Centralized platform detection logic.
/// Similar to Angular's platform service that provides platform information.
/// See STYLEGUIDE.md#13-best-practices---core-principles (§1.3) (DRY principle) and STYLEGUIDE.md#44-shared-utilities (§4.4) (Shared Utilities) for organization
class PlatformDetector {
  /// Get the current platform theme
  /// 🔹 Determines UI theme based on platform detection
  /// 🧠 Web platform uses Material by default but can be customized
  /// See STYLEGUIDE.md#22-dart-syntax-explained-with-angulartypescript-analogies (§2.2) for try-catch error handling patterns
  static PlatformTheme getCurrentTheme() {
    // 🧠 Web doesn't support Platform.isIOS/isAndroid, use try-catch
    try {
      if (Platform.isIOS) {
        return PlatformTheme.cupertino;
      } else if (Platform.isAndroid ||
          Platform.isWindows ||
          Platform.isLinux ||
          Platform.isMacOS) {
        return PlatformTheme.material;
      } else {
        // Web platform - default to Material but can be customized
        return PlatformTheme.web;
      }
    } catch (e) {
      // 🧠 Web platform - use Material theme
      return PlatformTheme.material;
    }
  }
}
