import 'package:flutter/material.dart';
import 'progress_indicator_strategy_factory.dart';

/// 🔶 Adaptive Progress Indicator Factory
///
/// Factory for creating adaptive progress indicator widgets.
/// Similar to Angular's component factory that creates instances
/// based on configuration and platform.
///
/// See STYLEGUIDE.md#42-meaningful-file-names (§4.2) (Co-location) and STYLEGUIDE.md#43-separate-files-by-role (§4.3) (Separate Files by Role)
/// for factory pattern organization guidelines.
class AdaptiveProgressIndicatorFactory {
  /// Create adaptive progress indicator based on platform
  /// 🔹 Returns platform-appropriate progress indicator widget
  /// 🧠 Self-contained factory that doesn't depend on central registry
  static Widget createProgressIndicator() {
    final strategy = ProgressIndicatorStrategyFactory.getStrategy();

    return strategy.createProgressIndicator();
  }
}
