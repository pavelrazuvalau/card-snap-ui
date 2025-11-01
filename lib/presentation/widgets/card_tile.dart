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
///
/// See STYLEGUIDE.md#32-const-constructors (§3.2) (const constructors), STYLEGUIDE.md#31-super-parameters (§3.1) (super.key),
/// and STYLEGUIDE.md#7-platform-style-guide-compliance (§7) (Platform Style Guides) for implementation guidelines.
library presentation.widgets;

import 'package:flutter/material.dart';
import '../../domain/entities/card.dart';
import 'package:card_snap_ui/l10n/app_localizations.dart';
import 'adaptive/adaptive_widget_module.dart';

// Note: This widget is a domain-specific presentation widget that displays loyalty cards.
// It uses adaptive infrastructure (adaptive_widget_module.dart) but is NOT part of the
// adaptive infrastructure itself. The adaptive/ folder contains reusable platform-agnostic
// UI components, while this widget is specific to the Card Snap domain.

/// Reusable widget for displaying a single card
/// 🔹 Stateless widget for performance
/// 🔹 Callback-based interaction (like Angular @Output)
/// See STYLEGUIDE.md#32-const-constructors (§3.2) for const constructors and STYLEGUIDE.md#31-super-parameters (§3.1) for super parameters
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
  /// 🧠 Uses map-based resolution via IconStrategyFactory
  IconData _getCreditCardIcon() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();
    final strategy = IconStrategyFactory.getStrategy(theme);
    return strategy.getCreditCardIcon();
  }

  /// Build trailing actions (edit, delete)
  /// 🔹 Uses Material PopupMenuButton (platform-agnostic)
  /// 🧠 Material UI provides consistent cross-platform behavior
  Widget _buildTrailingActions() {
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
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context).actionEdit),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete),
              const SizedBox(width: 8),
              Text(AppLocalizations.of(context).actionDelete),
            ],
          ),
        ),
      ],
    );
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
  /// 🧠 Uses map-based resolution via IconStrategyFactory
  Color _getSubtitleColor() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();
    final strategy = IconStrategyFactory.getStrategy(theme);
    return strategy.getSubtitleColor();
  }
}
