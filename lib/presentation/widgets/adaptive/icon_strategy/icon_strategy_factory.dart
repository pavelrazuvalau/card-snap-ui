/// 🔶 Icon Strategy Factory
///
/// Creates appropriate icon strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.icon_strategy.factory;

import 'icon_strategy_interface.dart';
import 'material_icon_strategy.dart';
import 'cupertino_icon_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific icon strategies
class IconStrategyFactory {
  static IconStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoIconStrategy(),
      () => MaterialIconStrategy(),
    );
  }
}
