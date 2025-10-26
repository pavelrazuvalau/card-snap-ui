/// 🔶 App Strategy Factory
///
/// Creates appropriate app strategy based on platform.
/// Uses StrategySelector to eliminate platform logic duplication.

import 'app_strategy_interface.dart';
import 'material_app_strategy.dart';
import 'cupertino_app_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// 🔶 App Strategy Factory
///
/// Creates appropriate app strategy based on platform.
class AppStrategyFactory {
  static AppStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoAppStrategy(),
      () => MaterialAppStrategy(),
    );
  }
}
