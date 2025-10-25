/// 🔶 Presentation Page: Card List
/// 
/// Main screen displaying all loyalty cards.
/// Similar to Angular components but using Flutter widgets and state management.
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
/// In Flutter/Dart, we use pages with simple state management for minimal startup.
library presentation.pages;

import 'package:flutter/material.dart';
import '../../domain/entities/card.dart';
import '../../domain/repositories/card_repository.dart';
import '../widgets/card_tile.dart';
import '../widgets/offline_indicator.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Snap Wallet'),
        actions: [
          // Offline indicator
          const OfflineIndicator(),
          // Add card button
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _navigateToAddCard,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddCard,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }
  
  /// Build the main body based on state
  /// 🔹 Reactive UI that responds to state changes
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
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
            ElevatedButton(
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
          const Icon(
            Icons.credit_card_outlined,
            size: 64,
            color: Colors.grey,
          ),
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
          ElevatedButton.icon(
            onPressed: _navigateToAddCard,
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('Add Card'),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${card.name} coming soon!')),
    );
  }
  
  /// Delete a card
  /// 🔹 Simple delete operation
  void _deleteCard(LoyaltyCard card) {
    showDialog(
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
  Future<void> _performDelete(String cardId) async {
    try {
      final result = await _cardRepository.deleteCard(cardId);
      
      if (result.isFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete card: ${result.errorOrNull!.message}')),
        );
        return;
      }
      
      // Reload cards to reflect changes
      await _loadCards();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete card: ${e.toString()}')),
      );
    }
  }
}