/// 🔶 Presentation Page: Card List
///
/// Main screen displaying all loyalty cards with cross-platform support.
/// Similar to Angular components but using Flutter widgets and adaptive state management.
///
/// In Angular, you'd have:
/// ```typescript
/// @Component({
///   selector: 'app-card-list',
///   template: `
///     <div *ngFor="let card of cards$ | async">
///       <app-card-tile [card]="card"></app-card-tile>
///     </div>
///   `
/// })
/// export class CardListComponent {
///   cards$ = this.cardService.getCards();
/// }
/// ```
///
/// In Flutter/Dart, we use pages with adaptive scaffolding and state management.
/// 🧠 This page now uses adaptive abstractions to support both Material and Cupertino themes,
/// ensuring consistent behavior across Android, iOS, and Web platforms.
library presentation.pages;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/entities/card.dart';
import '../../domain/repositories/card_repository.dart';
import '../widgets/card_tile.dart';
import '../widgets/offline_indicator.dart';
import '../widgets/adaptive/adaptive_widget_module.dart';
import '../../data/repositories/local_card_repository.dart';
import '../../data/datasources/local_card_datasource.dart';

/// Main page displaying all loyalty cards
/// 🔹 Full-screen UI component (like Angular page components)
/// 🔹 Simple state management for minimal startup
class CardListPage extends StatefulWidget {
  const CardListPage({super.key});

  @override
  State<CardListPage> createState() => _CardListPageState();
}

class _CardListPageState extends State<CardListPage> {
  late final CardRepository _cardRepository;
  List<LoyaltyCard> _cards = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeRepository();
  }

  /// Initialize repository and load cards
  /// 🔹 Proper initialization sequence
  Future<void> _initializeRepository() async {
    try {
      final dataSource = LocalCardDataSource();
      await dataSource.initialize();
      _cardRepository = LocalCardRepository(dataSource);
      _loadCards();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize app: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  /// Load cards from repository
  /// 🔹 Simple async operation
  Future<void> _loadCards() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _cardRepository.getAllCards();

      if (result.isFailure) {
        setState(() {
          _errorMessage = result.errorOrNull!.message;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _cards = result.dataOrNull!;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load cards: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🧠 Use adaptive scaffold that adapts to platform theme
    // Similar to Angular's platform-specific component rendering
    return AdaptiveWidgetFactory.createScaffold(
      appBar:
          AdaptiveWidgetFactory.createAppBar(
                title: 'Card Snap Wallet',
                actions: [
                  // Offline indicator
                  const OfflineIndicator(),
                  // Add card button
                  _buildAddCardButton(),
                ],
              )
              as PreferredSizeWidget?,
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Build adaptive add card button
  /// 🧠 Platform-specific button styling and behavior
  Widget _buildAddCardButton() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _navigateToAddCard,
          child: const Icon(CupertinoIcons.add),
        );
      case PlatformTheme.material:
      case PlatformTheme.web:
        return IconButton(
          icon: const Icon(Icons.add),
          onPressed: _navigateToAddCard,
        );
    }
  }

  /// Build adaptive floating action button
  /// 🧠 iOS doesn't use floating action buttons, so we adapt accordingly
  Widget? _buildFloatingActionButton() {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        // iOS doesn't typically use floating action buttons
        return null;
      case PlatformTheme.material:
      case PlatformTheme.web:
        return FloatingActionButton(
          onPressed: _navigateToAddCard,
          child: const Icon(Icons.qr_code_scanner),
        );
    }
  }

  /// Build the main body based on state
  /// 🔹 Reactive UI that responds to state changes
  Widget _buildBody() {
    if (_isLoading) {
      return Center(child: AdaptiveWidgetFactory.createProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading cards',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AdaptiveWidgetFactory.createButton(
              onPressed: _loadCards,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_cards.isEmpty) {
      return _buildEmptyState();
    }

    return _buildCardList();
  }

  /// Build empty state when no cards exist
  /// 🔹 User-friendly empty state (like Angular empty templates)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.credit_card_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No cards yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first loyalty card by scanning a QR code or barcode',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          AdaptiveWidgetFactory.createButton(
            onPressed: _navigateToAddCard,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_scanner),
                const SizedBox(width: 8),
                const Text('Add Card'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the list of cards
  /// 🔹 Scrollable list with card tiles
  Widget _buildCardList() {
    return RefreshIndicator(
      onRefresh: _loadCards,
      child: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return CardTile(
            card: card,
            onTap: () => _navigateToCardDetails(card),
            onEdit: () => _navigateToEditCard(card),
            onDelete: () => _deleteCard(card),
          );
        },
      ),
    );
  }

  /// Navigate to add card page
  /// 🔹 Navigation using Flutter's Navigator
  void _navigateToAddCard() {
    // TODO: Implement navigation to add card page
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add card functionality coming soon!')),
    );
  }

  /// Navigate to card details page
  /// 🔹 Pass card data through navigation
  void _navigateToCardDetails(LoyaltyCard card) {
    // TODO: Implement navigation to card details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Card details for ${card.name} coming soon!')),
    );
  }

  /// Navigate to edit card page
  /// 🔹 Pass card data for editing
  void _navigateToEditCard(LoyaltyCard card) {
    // TODO: Implement navigation to edit card page
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Edit ${card.name} coming soon!')));
  }

  /// Delete a card with adaptive dialog
  /// 🔹 Simple delete operation with platform-specific confirmation
  /// 🧠 iOS uses CupertinoAlertDialog, Material uses AlertDialog
  void _deleteCard(LoyaltyCard card) {
    final theme = AdaptiveWidgetFactory.getCurrentTheme();

    switch (theme) {
      case PlatformTheme.cupertino:
        _showCupertinoDeleteDialog(card);
        break;
      case PlatformTheme.material:
      case PlatformTheme.web:
        _showMaterialDeleteDialog(card);
        break;
    }
  }

  /// Show Cupertino-style delete confirmation dialog
  /// 🧠 iOS-specific dialog styling and interaction patterns
  void _showCupertinoDeleteDialog(LoyaltyCard card) {
    showCupertinoDialog<void>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Delete Card'),
        content: Text('Are you sure you want to delete "${card.name}"?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await _performDelete(card.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Show Material-style delete confirmation dialog
  /// 🧠 Material Design dialog styling and interaction patterns
  void _showMaterialDeleteDialog(LoyaltyCard card) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Card'),
        content: Text('Are you sure you want to delete "${card.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _performDelete(card.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  /// Perform the actual delete operation
  /// 🔹 Delete card from repository
  /// 🧠 Uses mounted check to prevent BuildContext usage after async operations
  Future<void> _performDelete(String cardId) async {
    try {
      final result = await _cardRepository.deleteCard(cardId);

      // Check if widget is still mounted before using BuildContext
      if (!mounted) return;

      if (result.isFailure) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Failed to delete card: ${result.errorOrNull!.message}',
              ),
            ),
          );
        }
        return;
      }

      // Reload cards to reflect changes
      await _loadCards();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Card deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete card: ${e.toString()}')),
        );
      }
    }
  }
}
