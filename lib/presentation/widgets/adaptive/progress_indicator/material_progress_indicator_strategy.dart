/// 🔶 Material Progress Indicator Strategy
///
/// Creates Material Design 3 progress indicators following Material Design Guidelines.
/// Reference: https://m3.material.io/components/progress-indicators
///
/// Material Design 3 specifications applied:
/// - Uses CircularProgressIndicator for loading states
/// - Uses primary color from theme
/// - Standard animation and sizing
///
/// Angular analogy: Angular Material Progress Spinner component.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.progress_indicator.material;

import 'package:flutter/material.dart';
import 'progress_indicator_strategy_interface.dart';

/// Material Design 3 progress indicator strategy implementation
/// 🔹 CircularProgressIndicator follows Material Design 3 specifications
/// 🔹 Uses theme's primary color
/// 🧠 Standard Material animation and sizing
class MaterialProgressIndicatorStrategy implements ProgressIndicatorStrategy {
  @override
  Widget createProgressIndicator() {
    // Material Design 3: CircularProgressIndicator uses standard Material animation
    return const CircularProgressIndicator();
  }
}
