/// 🔶 Theme Configuration Strategy Factory
///
/// Creates appropriate theme configuration strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.theme_config.factory;

import 'theme_config_strategy_interface.dart';
import 'material_theme_config_strategy.dart';
import 'cupertino_theme_config_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific theme configuration strategies
class ThemeConfigStrategyFactory {
  static ThemeConfigStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoThemeConfigStrategy(),
      () => MaterialThemeConfigStrategy(),
    );
  }
}
