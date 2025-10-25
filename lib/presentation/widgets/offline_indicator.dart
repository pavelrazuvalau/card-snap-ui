/// 🔶 Presentation Widget: Offline Indicator
/// 
/// Widget showing network connectivity status.
/// Similar to Angular service status indicators but using Flutter widgets.
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
/// In Flutter/Dart, we use widgets with connectivity monitoring.
library presentation.widgets;

import 'package:flutter/material.dart';

/// Widget indicating offline status
/// 🔹 Shows when device is offline
/// 🔹 Offline-first approach (from BUSINESS.md requirements)
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
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 4),
          Text(
            'Offline',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
