# Presentation Layer Tests

Tests for UI components, state management, and user interactions.

## 🎯 Test Focus

- **Widget rendering** - UI component display and behavior
- **State management** - BLoC/Riverpod state changes
- **User interactions** - Tap, swipe, and input handling
- **Navigation** - Route transitions and parameter passing

## 📁 Test Structure

```
test/presentation/
├── pages/               # Page widget tests
│   ├── card_list_page_test.dart # CardListPage tests
│   └── README.md        # Page testing guidelines
├── widgets/             # Widget component tests
│   ├── card_tile_test.dart # CardTile widget tests
│   ├── offline_indicator_test.dart # OfflineIndicator tests
│   └── README.md        # Widget testing guidelines
├── blocs/               # State management tests
│   ├── card_list_bloc_test.dart # CardListBloc tests
│   └── README.md        # BLoC testing guidelines
└── navigation/          # Navigation tests
    └── README.md        # Navigation testing guidelines
```

## 🧪 Test Examples

### Widget Tests
```dart
// test/presentation/widgets/card_tile_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/presentation/widgets/card_tile.dart';
import 'package:card_snap_ui/domain/entities/card.dart';

void main() {
  group('CardTile Widget', () {
    testWidgets('should display card information', (tester) async {
      // Arrange
      final card = createTestCard(
        name: 'Test Card',
        storeName: 'Test Store',
      );
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardTile(card: card),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Test Card'), findsOneWidget);
      expect(find.text('Test Store'), findsOneWidget);
      expect(find.text('QR Code'), findsOneWidget);
    });
    
    testWidgets('should call onTap when tapped', (tester) async {
      // Arrange
      bool tapped = false;
      final card = createTestCard();
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CardTile(
              card: card,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );
      
      await tester.tap(find.byType(CardTile));
      
      // Assert
      expect(tapped, isTrue);
    });
  });
}
```

### BLoC Tests
```dart
// test/presentation/blocs/card_list_bloc_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:card_snap_ui/presentation/blocs/card_list_bloc.dart';
import 'package:card_snap_ui/domain/repositories/card_repository.dart';

class MockCardRepository extends Mock implements CardRepository {}

void main() {
  group('CardListBloc', () {
    late CardListBloc bloc;
    late MockCardRepository mockRepository;
    
    setUp(() {
      mockRepository = MockCardRepository();
      bloc = CardListBloc(mockRepository);
    });
    
    tearDown(() {
      bloc.close();
    });
    
    blocTest<CardListBloc, CardListState>(
      'emits loaded state when cards are fetched successfully',
      build: () {
        when(() => mockRepository.getAllCards())
            .thenAnswer((_) async => Result.success([createTestCard()]));
        return bloc;
      },
      act: (bloc) => bloc.add(CardsLoadRequested()),
      expect: () => [
        CardListLoading(),
        CardListLoaded([createTestCard()]),
      ],
    );
    
    blocTest<CardListBloc, CardListState>(
      'emits error state when cards fetch fails',
      build: () {
        when(() => mockRepository.getAllCards())
            .thenAnswer((_) async => Result.failure(
              DataException('Network error'),
            ));
        return bloc;
      },
      act: (bloc) => bloc.add(CardsLoadRequested()),
      expect: () => [
        CardListLoading(),
        CardListError('Network error'),
      ],
    );
  });
}
```

### Page Tests
```dart
// test/presentation/pages/card_list_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_snap_ui/presentation/pages/card_list_page.dart';
import 'package:card_snap_ui/presentation/blocs/card_list_bloc.dart';

void main() {
  group('CardListPage', () {
    testWidgets('should display loading indicator when loading', (tester) async {
      // Arrange
      final bloc = MockCardListBloc();
      when(() => bloc.state).thenReturn(CardListLoading());
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CardListBloc>(
            create: (_) => bloc,
            child: const CardListPage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    
    testWidgets('should display cards when loaded', (tester) async {
      // Arrange
      final bloc = MockCardListBloc();
      when(() => bloc.state).thenReturn(
        CardListLoaded([createTestCard()]),
      );
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<CardListBloc>(
            create: (_) => bloc,
            child: const CardListPage(),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CardTile), findsOneWidget);
    });
  });
}
```

## 🎓 Educational Focus

### Angular/TypeScript Analogies
- **Widget Tests** ≈ Angular component tests
- **BLoC Tests** ≈ NgRx store tests
- **Page Tests** ≈ Angular page component tests
- **Navigation Tests** ≈ Angular routing tests

### Business Context
- **Offline-first UI** - Test offline state handling
- **Security UI** - Test secure data display
- **Multilingual UI** - Test i18n support

## 📋 TODO: Implementation

1. **CardTile widget tests** - Display and interaction
2. **CardListPage tests** - Page behavior and state
3. **CardListBloc tests** - State management logic
4. **Navigation tests** - Route handling

---

*Presentation tests ensure UI correctness and maintain educational value for Flutter development.*
