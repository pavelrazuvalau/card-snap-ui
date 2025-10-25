# Presentation Layer

The **Presentation Layer** handles UI, state management, and user interactions. This is similar to Angular's components, services, and state management (NgRx/Akita).

## Angular Analogy
In Angular, you'd have:
- **Components** - UI templates and logic
- **Services** - state management and business logic coordination
- **NgRx Store** - centralized state management
- **Guards** - route protection and navigation
- **Pipes** - data transformation for display

## Flutter/Dart Equivalent
- **Pages** (`presentation/pages/`) - full-screen UI (like Angular components)
- **Widgets** (`presentation/widgets/`) - reusable UI components
- **State Management** (`presentation/blocs/` or `presentation/providers/`) - like NgRx
- **Navigation** (`presentation/navigation/`) - routing and navigation logic

## State Management Options
Following ARCHITECTURE.md §6.1, we support:

### 1. BLoC Pattern (Recommended)
```dart
/// Similar to Angular NgRx: Actions → Reducer → State
class CardBloc extends Bloc<CardEvent, CardState> {
  final AddCard addCardUseCase; // Domain use case
  
  CardBloc(this.addCardUseCase) : super(CardInitial()) {
    on<AddCardRequested>(_onAddCardRequested);
  }
}
```

### 2. Riverpod (Alternative)
```dart
/// Similar to Angular services with reactive state
final cardProvider = StateNotifierProvider<CardNotifier, CardState>((ref) {
  return CardNotifier(ref.read(addCardUseCaseProvider));
});
```

## Key Principles
- **Reactive UI** - UI responds to state changes (like Angular change detection)
- **Separation of concerns** - UI logic separate from business logic
- **Offline-first UI** - graceful handling of network states
- **Multilingual support** - UI supports ru/en/uk/pl + extended languages

## Business Requirements Alignment
From BUSINESS.md:
- **Card scanning** - QR/barcode scanning UI
- **Offline indicators** - show network status
- **Encrypted storage** - secure data handling in UI
- **Export/Import** - user-initiated backup flows

## Files Structure
```
presentation/
├── pages/            # Full-screen UI (CardListPage, AddCardPage)
├── widgets/         # Reusable components (CardTile, ScanButton)
├── blocs/           # State management (or providers/)
├── navigation/      # Routing and navigation
└── themes/          # Material/Cupertino theming
```
