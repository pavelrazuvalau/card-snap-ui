/// 🔶 Scaffold Strategy Factory
///
/// Creates appropriate scaffold strategy based on platform.
/// Uses StrategySelector to eliminate platform logic duplication.

import 'scaffold_strategy_interface.dart';
import 'material_scaffold_strategy.dart';
import 'cupertino_scaffold_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// 🔶 Scaffold Strategy Factory
///
/// Creates appropriate scaffold strategy based on platform.
class ScaffoldStrategyFactory {
  static ScaffoldStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoScaffoldStrategy(),
      () => MaterialScaffoldStrategy(),
    );
  }
}
