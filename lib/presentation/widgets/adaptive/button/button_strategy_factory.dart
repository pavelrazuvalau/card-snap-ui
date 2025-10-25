/// 🔶 Button Strategy Factory
///
/// Creates appropriate button strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.button.factory;

import 'button_strategy_interface.dart';
import 'material_button_strategy.dart';
import 'cupertino_button_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific button strategies
class ButtonStrategyFactory {
  static ButtonStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoButtonStrategy(),
      () => MaterialButtonStrategy(),
    );
  }
}
