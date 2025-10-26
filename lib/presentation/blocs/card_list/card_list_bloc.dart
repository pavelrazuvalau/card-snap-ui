/// 🔶 Card List BLoC
///
/// Business Logic Component for card list state management.
/// Similar to Angular NgRx Effects + Reducers: handles business logic.
///
/// In Angular, you'd have:
/// ```typescript
/// @Effect()
/// loadCards$ = this.actions$.pipe(
///   ofType(LoadCards),
///   switchMap(() => this.cardService.getCards().pipe(
///     map(cards => new LoadCardsSuccess(cards)),
///     catchError(err => of(new LoadCardsFailure(err)))
///   ))
/// );
/// ```
///
/// In Flutter/Dart, we use BLoC pattern with events and states.
library presentation.blocs.card_list;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/card_repository.dart';
import 'card_list_event.dart';
import 'card_list_state.dart';

/// Card List BLoC
/// 🔹 Manages state for card list page
/// 🧠 Separates business logic from UI
/// 🧠 Similar to NgRx Effects + Reducers in Angular
class CardListBloc extends Bloc<CardListEvent, CardListState> {
  final CardRepository repository;

  CardListBloc(this.repository) : super(const CardListInitial()) {
    // Register event handlers
    on<LoadCardsEvent>(_onLoadCards);
    on<RefreshCardsEvent>(_onRefreshCards);
    on<AddCardEvent>(_onAddCard);
    on<DeleteCardEvent>(_onDeleteCard);
    on<EditCardEvent>(_onEditCard);
  }

  /// Handle LoadCardsEvent
  /// 🔹 Load all cards from repository
  /// 🧠 Similar to Angular service getAllCards() method
  Future<void> _onLoadCards(
    LoadCardsEvent event,
    Emitter<CardListState> emit,
  ) async {
    emit(const CardListLoading());

    try {
      final result = await repository.getAllCards();

      if (result.isFailure) {
        emit(CardListError(result.errorOrNull!.message));
        return;
      }

      final cards = result.dataOrNull!;

      if (cards.isEmpty) {
        emit(const CardListEmpty());
      } else {
        emit(CardListSuccess(cards));
      }
    } catch (e) {
      emit(CardListError('Failed to load cards: ${e.toString()}'));
    }
  }

  /// Handle RefreshCardsEvent
  /// 🔹 Reload cards from repository
  /// 🧠 Similar to Angular service refreshCards() method
  Future<void> _onRefreshCards(
    RefreshCardsEvent event,
    Emitter<CardListState> emit,
  ) async {
    try {
      final result = await repository.getAllCards();

      if (result.isFailure) {
        emit(CardListError(result.errorOrNull!.message));
        return;
      }

      final cards = result.dataOrNull!;

      if (cards.isEmpty) {
        emit(const CardListEmpty());
      } else {
        emit(CardListSuccess(cards));
      }
    } catch (e) {
      emit(CardListError('Failed to refresh cards: ${e.toString()}'));
    }
  }

  /// Handle AddCardEvent
  /// 🔹 Add new card to repository
  /// 🧠 Similar to Angular service addCard() method
  Future<void> _onAddCard(
    AddCardEvent event,
    Emitter<CardListState> emit,
  ) async {
    try {
      final result = await repository.addCard(event.card);

      if (result.isFailure) {
        emit(CardListError(result.errorOrNull!.message));
        return;
      }

      // Reload cards after successful add
      add(const RefreshCardsEvent());
    } catch (e) {
      emit(CardListError('Failed to add card: ${e.toString()}'));
    }
  }

  /// Handle DeleteCardEvent
  /// 🔹 Delete card from repository
  /// 🧠 Similar to Angular service deleteCard() method
  Future<void> _onDeleteCard(
    DeleteCardEvent event,
    Emitter<CardListState> emit,
  ) async {
    try {
      final result = await repository.deleteCard(event.cardId);

      if (result.isFailure) {
        emit(CardListError(result.errorOrNull!.message));
        return;
      }

      // Reload cards after successful delete
      add(const RefreshCardsEvent());
    } catch (e) {
      emit(CardListError('Failed to delete card: ${e.toString()}'));
    }
  }

  /// Handle EditCardEvent
  /// 🔹 Update card in repository
  /// 🧠 Similar to Angular service updateCard() method
  Future<void> _onEditCard(
    EditCardEvent event,
    Emitter<CardListState> emit,
  ) async {
    try {
      final result = await repository.updateCard(event.card);

      if (result.isFailure) {
        emit(CardListError(result.errorOrNull!.message));
        return;
      }

      // Reload cards after successful edit
      add(const RefreshCardsEvent());
    } catch (e) {
      emit(CardListError('Failed to edit card: ${e.toString()}'));
    }
  }
}
