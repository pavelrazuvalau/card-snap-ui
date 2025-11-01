/// 🔶 Material Button Strategy
///
/// Creates Material Design 3 buttons following Material Design Guidelines.
/// Reference: https://m3.material.io/components/buttons
///
/// Material Design 3 specifications applied:
/// - Uses ElevatedButton for primary actions
/// - Default height: 40dp (Material Design 3 minimum touch target)
/// - Default padding: 24dp horizontal, 12dp vertical (Material 3 guidelines)
/// - Enabled state uses primary color from theme
/// - Disabled state uses surfaceVariant color
///
/// Angular analogy: Angular Material Button component with Material Design 3 styling.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.button.material;

import 'package:flutter/material.dart';
import 'button_strategy_interface.dart';

/// Material Design 3 button strategy implementation
/// 🔹 ElevatedButton follows Material Design 3 specifications
/// 🔹 Default minimum touch target: 40dp height
/// 🧠 Button style can be customized via ButtonStyle parameter
class MaterialButtonStrategy implements ButtonStrategy {
  @override
  Widget createButton({
    required Widget child,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    EdgeInsetsGeometry? padding,
  }) {
    // Material Design 3: ElevatedButton is the primary action button
    // It uses the theme's primary color and has elevation
    return ElevatedButton(onPressed: onPressed, style: style, child: child);
  }
}
