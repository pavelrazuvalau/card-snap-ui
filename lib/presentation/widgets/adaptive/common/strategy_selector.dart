/// 🔶 Strategy Selector
///
/// Centralized logic for selecting platform-appropriate strategies.
/// This eliminates duplication of platform-selection logic across multiple strategy factories.
///
/// Similar to Angular's platform detection service that provides centralized platform decisions.
///
/// See STYLEGUIDE.md#13-best-practices---core-principles (§1.3) (DRY principle) and STYLEGUIDE.md#44-shared-utilities (§4.4) (Shared Utilities) for organization guidelines.
import '../common/platform_types.dart';

/// 🔶 Strategy Selector
///
/// Provides centralized platform selection logic for all widget types.
/// This follows DRY principle by eliminating repeated switch statements.
///
/// When adding new platform support, you only need to:
/// 1. Add the new strategy class
/// 2. Update this selector (one place, not scattered across factories)
class StrategySelector {
  /// Get platform theme for current runtime environment
  /// 🔹 Single source of truth for platform detection
  /// 🧠 Used by all strategy factories to maintain consistency
  static PlatformTheme getCurrentTheme() {
    return PlatformDetector.getCurrentTheme();
  }

  /// Determine if current platform is Cupertino (iOS)
  /// 🔹 Helper method for platform-specific logic
  static bool isCupertino() {
    return getCurrentTheme() == PlatformTheme.cupertino;
  }

  /// Determine if current platform is Material (Android, Web, Desktop)
  /// 🔹 Helper method for platform-specific logic
  static bool isMaterial() {
    final theme = getCurrentTheme();
    return theme == PlatformTheme.material || theme == PlatformTheme.web;
  }

  /// Get strategy based on platform theme
  /// 🔹 Generic method that can be used by any strategy factory
  /// 🧠 Reduces duplication by centralizing platform logic
  static T getStrategyForTheme<T>(
    PlatformTheme theme,
    T Function() cupertinoFactory,
    T Function() materialFactory,
  ) {
    switch (theme) {
      case PlatformTheme.cupertino:
        return cupertinoFactory();
      case PlatformTheme.material:
      case PlatformTheme.web:
        return materialFactory();
    }
  }

  /// Get strategy for current platform
  /// 🔹 Convenience method that doesn't require theme parameter
  static T getStrategyForCurrentPlatform<T>(
    T Function() cupertinoFactory,
    T Function() materialFactory,
  ) {
    return getStrategyForTheme(
      getCurrentTheme(),
      cupertinoFactory,
      materialFactory,
    );
  }
}
