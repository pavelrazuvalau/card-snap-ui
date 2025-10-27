/// 🔶 Card Strategy Factory
///
/// Creates appropriate card strategy based on platform.
/// Uses StrategySelector to eliminate platform logic duplication.

import 'card_strategy_interface.dart';
import 'material_card_strategy.dart';
import 'cupertino_card_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// 🔶 Card Strategy Factory
///
/// Creates appropriate card strategy based on platform.
/// 🔹 Delegate directly to StrategySelector to eliminate duplication
class CardStrategyFactory {
  static CardStrategy getStrategy() =>
      StrategySelector.getStrategyForCurrentPlatform(
        () => CupertinoCardStrategy(),
        () => MaterialCardStrategy(),
      );

  static CardStrategy getStrategyForTheme(PlatformTheme theme) =>
      StrategySelector.getStrategyForTheme(
        theme,
        () => CupertinoCardStrategy(),
        () => MaterialCardStrategy(),
      );
}
