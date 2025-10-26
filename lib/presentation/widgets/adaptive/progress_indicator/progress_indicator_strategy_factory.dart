/// 🔶 Progress Indicator Strategy Factory
///
/// Creates appropriate progress indicator strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.progress_indicator.factory;

import 'progress_indicator_strategy_interface.dart';
import 'material_progress_indicator_strategy.dart';
import 'cupertino_progress_indicator_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific progress indicator strategies
class ProgressIndicatorStrategyFactory {
  static ProgressIndicatorStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoProgressIndicatorStrategy(),
      () => MaterialProgressIndicatorStrategy(),
    );
  }
}
