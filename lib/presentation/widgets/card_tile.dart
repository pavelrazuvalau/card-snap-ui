/// 🔶 Presentation Widget: Card Tile
/// 
/// Reusable widget for displaying a single card.
/// Similar to Angular components but using Flutter widgets.
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
/// In Flutter/Dart, we use widgets with callbacks.
library presentation.widgets;

import 'package:flutter/material.dart';
import '../../domain/entities/card.dart';

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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: _buildCardIcon(),
        title: Text(
          card.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.storeName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              card.formatDisplayName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
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
  /// 🔹 Generic credit card icon
  Widget _buildFallbackIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getCardColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.credit_card,
        color: Colors.white,
        size: 24,
      ),
    );
  }
  
  /// Build trailing actions (edit, delete)
  /// 🔹 PopupMenuButton for actions
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
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit),
              SizedBox(width: 8),
              Text('Edit'),
            ],
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
  
  /// Get card color for theming
  /// 🔹 Uses card's color or generates from store name
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
}