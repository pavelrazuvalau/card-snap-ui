# Domain Layer

The **Domain Layer** contains pure business logic, independent of frameworks and external concerns. This is the heart of Clean Architecture - similar to Angular's business logic services but without any framework dependencies.

## Angular Analogy
In Angular, you'd have:
- `UserService` with business methods like `login()`, `register()`
- Domain models like `User`, `Product`, `Order`
- Business rules and validation logic
- Use cases as service methods

## Flutter/Dart Equivalent
- **Entities** (`domain/entities/`) - pure Dart business models
- **Use Cases** (`domain/usecases/`) - business operations (like Angular service methods)
- **Repository Interfaces** (`domain/repositories/`) - abstract data contracts
- **Value Objects** (`domain/value_objects/`) - immutable data containers

## Use Case Pattern
```dart
/// 🔶 Use Case: AddCard
/// Business operation for adding a loyalty card
/// Similar to Angular service method: addCard(cardData)
class AddCard {
  final CardRepository repository;
  
  AddCard(this.repository);
  
  /// Executes the business logic
  /// 🧠 Pure domain logic - no UI or network concerns
  Future<Result<Card>> execute(AddCardRequest request) async {
    // Business validation
    // Repository interaction
    // Return domain result
  }
}
```

## Key Principles
- **Pure Dart** - no Flutter imports allowed
- **Dependency Inversion** - depend on abstractions, not implementations
- **Single Responsibility** - each use case has one clear purpose
- **Testable** - easy to unit test without mocks

## Business Requirements Alignment
From BUSINESS.md:
- **Offline-first** - all use cases work without network
- **Encrypted storage** - sensitive operations handle encryption
- **Multilingual** - business logic supports i18n
- **Card management** - core use cases for loyalty cards

## Files Structure
```
domain/
├── entities/         # Business models (Card, User, Store)
├── repositories/     # Abstract repository interfaces
├── usecases/         # Business operations
└── value_objects/    # Immutable data containers
```
