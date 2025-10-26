/// 🔶 Icon Strategy Interface
///
/// Defines the contract for getting platform-appropriate icons.
/// Similar to Angular's icon service that provides platform-specific icons.
library presentation.widgets.adaptive.icon_strategy;

import 'package:flutter/material.dart';

/// 🔶 Base interface for icon strategy
///
/// Defines the contract for getting platform-appropriate icons.
/// Similar to Angular's icon service that provides platform-specific icons.
abstract class IconStrategy {
  IconData getCreditCardIcon();
  IconData getOfflineIcon();
  Color getSubtitleColor();
}
