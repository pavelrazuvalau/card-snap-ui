/// 🔶 Presentation Page: Card List
///
/// Main screen displaying all loyalty cards with cross-platform support.
/// Similar to Angular components but using Flutter widgets with BLoC state management.
///
/// In Angular, you'd have:
/// ```typescript
/// @Component({
///   selector: 'app-card-list',
///   template: `
///     <div *ngIf="cards$ | async as cards">
///       <app-card-tile *ngFor="let card of cards" [card]="card"></app-card-tile>
///     </div>
///   `
/// })
/// export class CardListComponent {
///   cards$ = this.store.select(fromCards.getCards);
///   constructor(private store: Store<CardState>) {}
/// }
/// ```
///
/// In Flutter/Dart, we use BLoC pattern with BlocBuilder for reactive UI.
/// 🧠 This page uses BLoC pattern instead of StatefulWidget + setState
/// 🧠 Following enterprise Flutter best practices
library presentation.pages;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/di/service_locator.dart';
import '../../data/repositories/local_card_repository.dart';
import '../../domain/entities/card.dart';
import 'package:card_snap_ui/l10n/app_localizations.dart';
import '../widgets/card_tile.dart';
import '../widgets/offline_indicator.dart';
import '../blocs/card_list/card_list_bloc.dart';
import '../blocs/card_list/card_list_event.dart';
import '../blocs/card_list/card_list_state.dart';
import '../../core/platform/locale_controller.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

/// Main page displaying all loyalty cards
/// 🔹 Uses BLoC pattern for state management (enterprise best practice)
/// 🔹 StatelessWidget with BlocBuilder for reactive UI
/// 🧠 Similar to Angular components with NgRx store subscription
class CardListPage extends StatelessWidget {
  const CardListPage({super.key});

  /// Create BLoC instance
  /// 🔹 Gets repository from DI container
  /// 🧠 Similar to Angular dependency injection
  CardListBloc _createBloc() {
    final repository = serviceLocator<LocalCardRepository>();
    return CardListBloc(repository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _createBloc()..add(const LoadCardsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppConstants.appName),
          actions: [
            const OfflineIndicator(),
            _LocaleMenu(),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _navigateToAddCard(context),
            ),
          ],
        ),
        body: const CardListBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddCard(context),
          child: const Icon(Icons.qr_code_scanner),
        ),
      ),
    );
  }

  /// Navigate to add card page
  void _navigateToAddCard(BuildContext context) {
    // TODO: Implement navigation
    // Navigator.push(context, MaterialPageRoute(builder: (context) => AddCardPage()));
  }
}

/// Body widget that reacts to BLoC state changes
/// 🔹 Uses BlocBuilder for reactive UI
/// 🧠 Similar to Angular async pipe in template
class CardListBody extends StatelessWidget {
  const CardListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardListBloc, CardListState>(
      builder: (context, state) {
        if (state is CardListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CardListError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(color: Colors.red)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<CardListBloc>().add(const LoadCardsEvent());
                  },
                  child: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          );
        }

        if (state is CardListEmpty) {
          return _buildEmptyState(context);
        }

        if (state is CardListSuccess) {
          final cards = state.cards; // List<LoyaltyCard>
          return _buildCardList(context, cards);
        }

        return Center(child: Text(AppLocalizations.of(context).unknownState));
      },
    );
  }

  /// Build empty state when no cards exist
  /// 🔹 User-friendly empty state
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.credit_card_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context).noCardsYet,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context).emptyHint,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Build the list of cards
  /// 🔹 Scrollable list with card tiles
  Widget _buildCardList(BuildContext context, List<LoyaltyCard> cards) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CardListBloc>().add(const RefreshCardsEvent());
      },
      child: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return CardTile(
            card: card,
            onTap: () => _navigateToCardDetails(context),
            onEdit: () => _navigateToEditCard(context),
            onDelete: () => _deleteCard(context, card.id),
          );
        },
      ),
    );
  }

  /// Navigate to card details
  void _navigateToCardDetails(BuildContext context) {
    // TODO: Implement navigation
  }

  /// Navigate to edit card
  void _navigateToEditCard(BuildContext context) {
    // TODO: Implement navigation
  }

  /// Delete card
  void _deleteCard(BuildContext context, String cardId) {
    context.read<CardListBloc>().add(DeleteCardEvent(cardId));
  }
}

/// Language selector menu (system default + supported locales)
class _LocaleMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const locales = AppLocalizations.supportedLocales;
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (value) {
        if (value == 'system') {
          LocaleController.instance.setLocale(null);
          return;
        }
        LocaleController.instance.setLocale(Locale(value));
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'system',
          child: Text(l10n.languageSystemDefault),
        ),
        const PopupMenuDivider(),
        ...locales.map((loc) => PopupMenuItem<String>(
              value: loc.languageCode,
              child: Text(
                LocaleNames.of(context)!.nameOf(loc.toLanguageTag()) ??
                    loc.languageCode,
              ),
            )),
      ],
    );
  }
}
