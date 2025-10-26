/// 🔶 Card List States
///
/// States for card list state management using BLoC pattern.
/// Similar to Angular NgRx States: represent UI state at any time.
library presentation.blocs.card_list;

import 'package:equatable/equatable.dart';
import '../../../domain/entities/card.dart';

/// Base class for card list states
/// 🔹 All states extend this class for type safety
/// 🧠 Similar to NgRx State in Angular
abstract class CardListState extends Equatable {
  const CardListState();

  @override
  List<Object?> get props => [];
}

/// Initial state
/// 🔹 App hasn't started loading yet
/// 🧠 Similar to Angular component before ngOnInit
class CardListInitial extends CardListState {
  const CardListInitial();
}

/// Loading state
/// 🔹 Data is being fetched from repository
/// 🧠 Similar to Angular loading flag in component
class CardListLoading extends CardListState {
  const CardListLoading();
}

/// Success state
/// 🔹 Cards loaded successfully
/// 🧠 Similar to Angular component with data after async pipe resolves
class CardListSuccess extends CardListState {
  final List<LoyaltyCard> cards;

  const CardListSuccess(this.cards);

  @override
  List<Object?> get props => [cards];
}

/// Error state
/// 🔹 Failed to load cards
/// 🧠 Similar to Angular error handling in component
class CardListError extends CardListState {
  final String message;

  const CardListError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Empty state
/// 🔹 No cards available
/// 🧠 Similar to Angular empty state in template
class CardListEmpty extends CardListState {
  const CardListEmpty();
}
