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
library presentation.widgets;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'adaptive/adaptive_widget_module.dart';

/// Widget indicating offline status with platform-specific styling
/// 🔹 Shows when device is offline
/// 🔹 Offline-first approach (from BUSINESS.md requirements)
/// 🧠 Integrates with browser launcher platform detection for consistent theming
class OfflineIndicator extends StatelessWidget {
  const OfflineIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement actual connectivity monitoring
    // For now, show as always online
    const isOffline = false;

    if (!isOffline) {
      return const SizedBox.shrink();
    }

    // 🧠 Use adaptive card widget for consistent platform theming
    // Similar to Angular's platform-specific component rendering
    return AdaptiveWidgetFactory.createCard(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getOfflineIcon(),
            color: _getOfflineColor(),
            size: 16,
          ),
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

  /// Get platform-appropriate offline icon
  /// 🔹 Returns platform-specific icons
  /// 🧠 iOS uses Cupertino icons, Material uses Material icons
  IconData _getOfflineIcon() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoIcons.wifi_slash;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Icons.wifi_off;
    }
  }

  /// Get platform-appropriate offline color
  /// 🔹 Returns platform-specific colors
  /// 🧠 iOS uses Cupertino colors, Material uses Material colors
  Color _getOfflineColor() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoColors.white;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Colors.white;
    }
  }
}
