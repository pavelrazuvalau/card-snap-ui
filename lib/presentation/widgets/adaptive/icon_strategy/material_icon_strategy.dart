/// 🔶 Material Icon Strategy
///
/// Provides Material Design icons and colors.
/// Reference: https://fonts.google.com/icons
///
/// Material Design 3 icon specifications applied:
/// - Uses Material Icons for consistency
/// - Uses Material Design color palette
///
/// Angular analogy: Angular Material Icon service.

library presentation.widgets.adaptive.icon_strategy.material;

import 'package:flutter/material.dart';
import 'icon_strategy_interface.dart';

/// Material Design icon strategy implementation
/// 🔹 Uses Material Icons
/// 🔹 Uses Material Design colors
class MaterialIconStrategy implements IconStrategy {
  @override
  IconData getCreditCardIcon() => Icons.credit_card;

  @override
  IconData getOfflineIcon() => Icons.wifi_off;

  @override
  Color getSubtitleColor() => Colors.grey[600]!;
}
