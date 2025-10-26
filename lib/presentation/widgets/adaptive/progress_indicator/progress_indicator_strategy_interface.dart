/// 🔶 Progress Indicator Strategy Interface
///
/// Defines the contract for creating progress indicators across different platforms.
/// Similar to Angular's abstract class that defines common interface.
library presentation.widgets.adaptive.progress_indicator;

import 'package:flutter/material.dart';

/// 🔶 Base interface for progress indicator strategy
///
/// Defines the contract for creating progress indicators across different platforms.
/// Similar to Angular's abstract class that defines common interface.
abstract class ProgressIndicatorStrategy {
  Widget createProgressIndicator();
}
