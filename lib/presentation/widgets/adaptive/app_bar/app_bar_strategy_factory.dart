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
class AppBarStrategyFactory {
  static AppBarStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoAppBarStrategy(),
      () => MaterialAppBarStrategy(),
    );
  }
}
