/// 🔶 Dialog Strategy Factory
///
/// Creates appropriate dialog strategy based on platform.
/// Similar to Angular's factory that returns different implementations.
library presentation.widgets.adaptive.dialog.factory;

import 'dialog_strategy_interface.dart';
import 'material_dialog_strategy.dart';
import 'cupertino_dialog_strategy.dart';
import '../common/platform_types.dart';
import '../common/strategy_selector.dart';

/// Factory for creating platform-specific dialog strategies
class DialogStrategyFactory {
  static DialogStrategy getStrategy(PlatformTheme theme) {
    return StrategySelector.getStrategyForTheme(
      theme,
      () => CupertinoDialogStrategy(),
      () => MaterialDialogStrategy(),
    );
  }
}
