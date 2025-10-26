/// 🔶 Theme Configuration Strategy Interface
///
/// Defines the contract for theme configuration across different platforms.
/// Similar to Angular's theme service that provides platform-specific styling.
library presentation.widgets.adaptive.theme_config;

import 'package:flutter/material.dart';

/// 🔶 Base interface for theme configuration strategy
///
/// Defines the contract for theme configuration across different platforms.
/// Similar to Angular's theme service that provides platform-specific styling.
abstract class ThemeConfigStrategy {
  Color getPrimaryColor(BuildContext context);
  TextTheme getTextTheme(BuildContext context);
  IconThemeData getIconTheme(BuildContext context);
}
