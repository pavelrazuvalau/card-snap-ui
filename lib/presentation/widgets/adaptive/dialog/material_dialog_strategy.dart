/// 🔶 Material Dialog Strategy
///
/// Creates Material Design 3 dialogs following Material Design Guidelines.
/// Reference: https://m3.material.io/components/dialogs
///
/// Material Design 3 specifications applied:
/// - Uses AlertDialog for modal dialogs
/// - Default border radius: 28dp (Material 3 specification)
/// - Support for title, content, and actions
///
/// Angular analogy: Angular Material Dialog component with Material Design 3 styling.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements
/// and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation standards with style guide references.

library presentation.widgets.adaptive.dialog.material;

import 'package:flutter/material.dart';
import 'dialog_strategy_interface.dart';

/// Material Design 3 dialog strategy implementation
/// 🔹 AlertDialog follows Material Design 3 specifications
/// 🔹 Default border radius: 28dp (Material 3 specification)
/// 🧠 Dialog can be customized via theme
class MaterialDialogStrategy implements DialogStrategy {
  @override
  Widget createDialog({
    required String title,
    required String content,
    required List<Widget> actions,
  }) {
    // Material Design 3: AlertDialog uses standard Material elevation and styling
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}
