/// 🔶 Material Theme Configuration Strategy
///
/// Provides Material Design theme configuration.
/// Reference: https://m3.material.io/design/material-theming
///
/// Material Design 3 theme configuration applied:
/// - Uses Theme.of(context) for Material colors, typography, and iconography
/// - Primary color from Material theme
/// - Material text theme
/// - Material icon theme
///
/// Angular analogy: Angular Material theme service.

library presentation.widgets.adaptive.theme_config.material;

import 'package:flutter/material.dart';
import 'theme_config_strategy_interface.dart';

/// Material Design theme configuration strategy implementation
/// 🔹 Uses Material theme for all configuration
/// 🔹 Follows Material Design 3 specifications
class MaterialThemeConfigStrategy implements ThemeConfigStrategy {
  @override
  Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  @override
  TextTheme getTextTheme(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  @override
  IconThemeData getIconTheme(BuildContext context) {
    return Theme.of(context).iconTheme;
  }
}
