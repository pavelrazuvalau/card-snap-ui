/// 🔶 List Tile Strategy Factory
///
/// Creates appropriate list tile strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.list_tile.factory;

import 'list_tile_strategy_interface.dart';
import 'material_list_tile_strategy.dart';
import 'cupertino_list_tile_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific list tile strategies
class ListTileStrategyFactory {
  static ListTileStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoListTileStrategy(),
      () => MaterialListTileStrategy(),
    );
  }
}
