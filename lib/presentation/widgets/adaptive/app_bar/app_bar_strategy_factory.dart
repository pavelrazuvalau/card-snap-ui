/// 🔶 App Bar Strategy Factory
///
/// Creates appropriate app bar strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.app_bar.factory;

import 'app_bar_strategy_interface.dart';
import 'material_app_bar_strategy.dart';
import 'cupertino_app_bar_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific app bar strategies
/// 🔹 Delegate directly to StrategySelector to eliminate duplication
class AppBarStrategyFactory {
  /// Get strategy for current platform
  static AppBarStrategy getStrategy() =>
      StrategySelector.getStrategyForCurrentPlatform(
        () => CupertinoAppBarStrategy(),
        () => MaterialAppBarStrategy(),
      );

  /// Get strategy for specific platform theme
  static AppBarStrategy getStrategyForTheme(PlatformTheme theme) =>
      StrategySelector.getStrategyForTheme(
        theme,
        () => CupertinoAppBarStrategy(),
        () => MaterialAppBarStrategy(),
      );
}
