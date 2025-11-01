/// 🔶 Card List Events
///
/// Events for card list state management using BLoC pattern.
/// Similar to Angular NgRx Actions: trigger state changes.
///
/// See STYLEGUIDE.md#32-const-constructors (§3.2) for const constructors and STYLEGUIDE.md#22-dart-syntax-explained-with-angulartypescript-analogies (§2.2) for sealed classes.
library presentation.blocs.card_list;

import 'package:equatable/equatable.dart';
import '../../../domain/entities/card.dart';

/// Base class for card list events
/// 🔹 All events extend this class for type safety
/// 🧠 Similar to NgRx Actions in Angular
/// See STYLEGUIDE.md#32-const-constructors (§3.2) for const constructors
abstract class CardListEvent extends Equatable {
  const CardListEvent();

  @override
  List<Object?> get props => [];
}

/// Event: Load all cards
/// 🔹 Triggered when page initializes
/// 🧠 Similar to Angular service getCards() method
class LoadCardsEvent extends CardListEvent {
  const LoadCardsEvent();
}

/// Event: Refresh cards
/// 🔹 Triggered when user pulls to refresh
/// 🧠 Similar to Angular service refreshCards() method
class RefreshCardsEvent extends CardListEvent {
  const RefreshCardsEvent();
}

/// Event: Add new card
/// 🔹 Triggered when user adds a card
/// 🧠 Similar to Angular service addCard() method
class AddCardEvent extends CardListEvent {
  final LoyaltyCard card;

  const AddCardEvent(this.card);

  @override
  List<Object?> get props => [card];
}

/// Event: Delete card
/// 🔹 Triggered when user deletes a card
/// 🧠 Similar to Angular service deleteCard() method
class DeleteCardEvent extends CardListEvent {
  final String cardId;

  const DeleteCardEvent(this.cardId);

  @override
  List<Object?> get props => [cardId];
}

/// Event: Edit card
/// 🔹 Triggered when user edits a card
/// 🧠 Similar to Angular service updateCard() method
class EditCardEvent extends CardListEvent {
  final LoyaltyCard card;

  const EditCardEvent(this.card);

  @override
  List<Object?> get props => [card];
}
