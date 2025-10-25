/// 🔶 Presentation Widget: Card Tile
///
/// Reusable widget for displaying a single card with cross-platform support.
/// Similar to Angular components but using Flutter widgets with adaptive theming.
///
/// In Angular, you'd have:
/// ```typescript
/// @Component({
///   selector: 'app-card-tile',
///   template: `
///     <div class="card-tile" (click)="onTap()">
///       <img [src]="card.imageUrl" [alt]="card.name">
///       <h3>{{ card.name }}</h3>
///       <p>{{ card.storeName }}</p>
///     </div>
///   `
/// })
/// export class CardTileComponent {
///   @Input() card: Card;
///   @Output() tap = new EventEmitter<void>();
/// }
/// ```
///
/// In Flutter/Dart, we use widgets with callbacks and adaptive theming.
/// 🧠 This widget now uses adaptive abstractions to support both Material and Cupertino themes,
/// ensuring consistent behavior across Android, iOS, and Web platforms.
library presentation.widgets;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/card.dart';
import 'adaptive/adaptive_widget_module.dart';

/// Reusable widget for displaying a single card
/// 🔹 Stateless widget for performance
/// 🔹 Callback-based interaction (like Angular @Output)
class CardTile extends StatelessWidget {
  final LoyaltyCard card;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const CardTile({
    super.key,
    required this.card,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // 🧠 Use adaptive card widget that adapts to platform theme
    // Similar to Angular's platform-specific component rendering
    return AdaptiveWidgetFactory.createCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AdaptiveWidgetFactory.createListTile(
        leading: _buildCardIcon(),
        title: Text(
          card.name,
          style: AdaptiveThemeConfig.getTextTheme(context).titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.storeName,
              style: AdaptiveThemeConfig.getTextTheme(context).bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              card.formatDisplayName,
              style: AdaptiveThemeConfig.getTextTheme(
                context,
              ).bodySmall?.copyWith(color: _getSubtitleColor()),
            ),
          ],
        ),
        trailing: _buildTrailingActions(),
        onTap: onTap,
      ),
    );
  }

  /// Build card icon or image
  /// 🔹 Shows store logo if available, fallback to generic icon
  Widget _buildCardIcon() {
    if (card.imageUrl != null && card.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          card.imageUrl!,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackIcon();
          },
        ),
      );
    }

    return _buildFallbackIcon();
  }

  /// Build fallback icon when no image available
  /// 🔹 Generic credit card icon with platform-specific styling
  Widget _buildFallbackIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(_getCreditCardIcon(), color: Colors.white, size: 24),
    );
  }

  /// Get platform-appropriate credit card icon
  /// 🔹 Returns platform-specific icons
  /// 🧠 iOS uses Cupertino icons, Material uses Material icons
  IconData _getCreditCardIcon() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoIcons.creditcard;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Icons.credit_card;
    }
  }

  /// Build trailing actions (edit, delete)
  /// 🔹 Adaptive popup menu for actions
  /// 🧠 iOS uses CupertinoActionSheet, Material uses PopupMenuButton
  Widget _buildTrailingActions() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _showCupertinoActionSheet(),
          child: const Icon(CupertinoIcons.ellipsis),
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit?.call();
                break;
              case 'delete':
                onDelete?.call();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [Icon(Icons.edit), SizedBox(width: 8), Text('Edit')],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        );
    }
  }

  /// Show Cupertino action sheet for iOS
  /// 🧠 iOS-specific interaction pattern using action sheets
  void _showCupertinoActionSheet() {
    // This would be implemented with proper context access
    // For now, we'll use the callbacks directly
    // In a real implementation, you'd use showCupertinoModalPopup
    onEdit?.call();
  }

  /// Get card color for theming
  /// 🔹 Uses card's color or generates from store name
  /// 🧠 Platform-agnostic color generation ensures consistent theming
  Color _getCardColor() {
    if (card.colorHex != null && card.colorHex!.isNotEmpty) {
      try {
        return Color(int.parse(card.colorHex!.replaceFirst('#', '0xFF')));
      } catch (e) {
        // Fallback to generated color
      }
    }

    // Generate color from store name hash
    final hash = card.storeName.hashCode;
    return Color.fromARGB(
      255,
      (hash & 0xFF0000) >> 16,
      (hash & 0x00FF00) >> 8,
      hash & 0x0000FF,
    );
  }

  /// Get platform-appropriate subtitle color
  /// 🔹 Returns platform-specific subtitle colors
  /// 🧠 iOS uses system grey, Material uses theme-based grey
  Color _getSubtitleColor() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoColors.systemGrey;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return Colors.grey[600]!;
    }
  }
}
