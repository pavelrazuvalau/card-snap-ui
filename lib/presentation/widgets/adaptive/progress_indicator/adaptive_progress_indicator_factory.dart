import 'package:flutter/material.dart';
import '../common/platform_types.dart';
import 'progress_indicator_strategy_factory.dart';

/// 🔶 Adaptive Progress Indicator Factory
///
/// Factory for creating adaptive progress indicator widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
class AdaptiveProgressIndicatorFactory {
  /// Create adaptive progress indicator based on platform
  /// 🔹 Returns platform-appropriate progress indicator widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createProgressIndicator() {
    final theme = PlatformDetector.getCurrentTheme();
    final strategy = ProgressIndicatorStrategyFactory.getStrategy(theme);

    return strategy.createProgressIndicator();
  }
}
