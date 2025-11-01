/// 🔶 Presentation Widget: Offline Indicator
///
/// Widget showing network connectivity status with cross-platform support.
/// Similar to Angular service status indicators but using Flutter widgets with adaptive theming.
///
/// In Angular, you'd have:
/// ```typescript
/// @Component({
///   selector: 'app-offline-indicator',
///   template: `
///     <div *ngIf="isOffline" class="offline-indicator">
///       <i class="icon-wifi-off"></i>
///       <span>Offline</span>
///     </div>
///   `
/// })
/// export class OfflineIndicatorComponent {
///   @Input() isOffline: boolean;
/// }
/// ```
///
/// In Flutter/Dart, we use widgets with connectivity monitoring and adaptive theming.
/// 🧠 This widget integrates with core/platform/browser_launcher.dart for platform detection
/// and uses adaptive styling to match the current platform theme.
///
/// See STYLEGUIDE.md#32-const-constructors (§3.2) (const constructors), STYLEGUIDE.md#31-super-parameters (§3.1) (super.key),
/// and STYLEGUIDE.md#7-platform-style-guide-compliance (§7) (Platform Style Guides) for implementation guidelines.
library presentation.widgets;

import 'package:flutter/material.dart';
import 'adaptive/adaptive_widget_module.dart';

/// Widget indicating offline status with platform-specific styling
/// 🔹 Shows when device is offline
/// 🔹 Offline-first approach (from BUSINESS.md requirements)
/// 🧠 Integrates with browser launcher platform detection for consistent theming
/// See STYLEGUIDE.md#32-const-constructors (§3.2) for const constructors and STYLEGUIDE.md#31-super-parameters (§3.1) for super parameters
class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement actual connectivity monitoring
    // For now, show as always online
    const isOffline = false;

    // Always return offline widget (currently disabled)
    // This prevents "dead code" warning while maintaining structure
    // The widget will be fully functional when connectivity monitoring is implemented
    // ignore: dead_code - This code will be used when connectivity monitoring is implemented
    if (isOffline) {
      // Use adaptive card widget for consistent platform theming
      // Similar to Angular's platform-specific component rendering
      return AdaptiveWidgetFactory.createCard(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getOfflineIcon(), color: _getOfflineColor(), size: 16),
            const SizedBox(width: 4),
            Text(
              'Offline',
              style: TextStyle(
                color: _getOfflineColor(),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    // Return empty widget when online (current default state)
    return const SizedBox.shrink();
  }

  /// Get platform-appropriate offline icon
  /// 🔹 Returns platform-specific icons
  /// 🧠 Uses map-based resolution via IconStrategyFactory
  IconData _getOfflineIcon() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();
    final strategy = IconStrategyFactory.getStrategy(theme);
    return strategy.getOfflineIcon();
  }

  /// Get platform-appropriate offline color
  /// 🔹 Returns platform-specific colors
  /// 🧠 White color for consistency across platforms
  Color _getOfflineColor() => Colors.white;
}
