# Test Structure & Strategy

This directory contains comprehensive tests for Card Snap UI, organized by Clean Architecture layers.

## 📁 Test Organization

```
test/
├── domain/              # Domain layer tests
│   ├── entities/        # Entity validation tests
│   ├── usecases/        # Use case business logic tests
│   └── repositories/    # Repository interface tests
├── data/                # Data layer tests
│   ├── models/          # Data model serialization tests
│   ├── datasources/     # Data source implementation tests
│   └── repositories/     # Repository implementation tests
├── presentation/        # Presentation layer tests
│   ├── pages/           # Page widget tests
│   ├── widgets/         # Widget component tests
│   └── blocs/           # State management tests
├── core/                # Core layer tests
│   ├── constants/       # Constants validation tests
│   ├── errors/          # Error handling tests
│   └── utils/           # Utility function tests
└── integration/        # End-to-end tests
    ├── card_management/ # Card CRUD operations
    ├── offline_mode/    # Offline functionality
    └── security/        # Encryption and security
```

## 🎯 Testing Strategy

### Unit Tests (Domain & Data Layers)
- **Purpose**: Validate business logic and data operations
- **Tools**: `flutter_test`, `mocktail`
- **Coverage**: 90%+ for domain layer, 80%+ for data layer
- **Focus**: Pure Dart code, no Flutter dependencies

### Widget Tests (Presentation Layer)
- **Purpose**: Verify UI rendering and user interactions
- **Tools**: `flutter_test`
- **Coverage**: 70%+ for critical UI components
- **Focus**: Widget behavior, state changes, user input

### Integration Tests (End-to-End)
- **Purpose**: Validate complete user journeys
- **Tools**: `integration_test`
- **Coverage**: All critical user flows
- **Focus**: Card scanning, offline operation, backup/restore

## 🧪 Test Categories

### Domain Layer Tests
```dart
// Example: Card entity validation
test('Card entity should validate required fields', () {
  final card = Card(
    id: 'test-id',
    name: 'Test Card',
    storeName: 'Test Store',
    barcodeData: '123456789',
    format: BarcodeFormat.qrCode,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  
  expect(card.isValid, isTrue);
});
```

### Data Layer Tests
```dart
// Example: Repository implementation
test('LocalCardRepository should save and retrieve cards', () async {
  final repository = LocalCardRepository(mockDataSource);
  final card = createTestCard();
  
  await repository.addCard(card);
  final retrieved = await repository.getCardById(card.id);
  
  expect(retrieved.dataOrNull, equals(card));
});
```

### Presentation Layer Tests
```dart
// Example: BLoC state management
test('CardListBloc should emit loaded state when cards are fetched', () {
  when(mockRepository.getAllCards()).thenAnswer((_) async => 
    Result.success([createTestCard()]));
  
  bloc.add(CardsLoadRequested());
  
  expectLater(bloc.stream, emitsInOrder([
    CardListLoading(),
    CardListLoaded([createTestCard()]),
  ]));
});
```

## 🔍 Test Data & Fixtures

### Test Card Factory
```dart
// test/fixtures/card_factory.dart
Card createTestCard({
  String? id,
  String? name,
  String? storeName,
  BarcodeFormat? format,
}) {
  return Card(
    id: id ?? 'test-card-${DateTime.now().millisecondsSinceEpoch}',
    name: name ?? 'Test Card',
    storeName: storeName ?? 'Test Store',
    barcodeData: '123456789',
    format: format ?? BarcodeFormat.qrCode,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
```

### Mock Repository
```dart
// test/mocks/mock_card_repository.dart
class MockCardRepository extends Mock implements CardRepository {
  @override
  Future<Result<List<Card>>> getAllCards() => 
    Future.value(Result.success([]));
}
```

## 🚀 Running Tests

### Unit Tests
```bash
# Run all unit tests
flutter test

# Run specific test file
flutter test test/domain/entities/card_test.dart

# Run with coverage
flutter test --coverage
```

### Integration Tests
```bash
# Run integration tests
flutter test integration_test/

# Run on specific device
flutter test integration_test/ -d android
```

### Widget Tests
```bash
# Run widget tests
flutter test test/presentation/

# Run with golden file updates
flutter test --update-goldens
```

## 📊 Coverage Requirements

### Minimum Coverage Targets
- **Domain Layer**: 90%+ (business logic must be bulletproof)
- **Data Layer**: 80%+ (data operations critical for offline-first)
- **Presentation Layer**: 70%+ (UI behavior and state management)
- **Core Layer**: 85%+ (cross-cutting concerns)

### Coverage Reports
- **Local**: `coverage/lcov.info` generated after tests
- **CI/CD**: Uploaded to Codecov for tracking
- **Thresholds**: Fail build if coverage drops below targets

## 🎓 Educational Testing

### Angular/TypeScript Analogies
- **Jest → flutter_test**: Similar testing framework concepts
- **Jasmine → expect**: Similar assertion syntax
- **Angular Testing Utilities → Flutter Widget Testing**: Component testing approaches
- **NgRx Testing → BLoC Testing**: State management testing patterns

### Test Documentation
- **Comments**: Explain what each test validates and why
- **Business Context**: Link tests to BUSINESS.md requirements
- **Architecture Alignment**: Ensure tests follow Clean Architecture principles

## 📋 TODO: Test Implementation

### Immediate Tasks
1. **Set up test structure** - Create test directories and base files
2. **Implement domain tests** - Start with Card entity and AddCard use case
3. **Add data layer tests** - Repository and data source implementations
4. **Create widget tests** - CardTile and CardListPage components

### Future Enhancements
1. **Integration tests** - End-to-end user journeys
2. **Performance tests** - Card rendering speed validation
3. **Security tests** - Encryption and data protection
4. **Accessibility tests** - Screen reader and accessibility compliance

## 🔗 Related Documentation

- **[Architecture Guide](../ARCHITECTURE.md)** - Testing strategy and patterns
- **[Business Requirements](../BUSINESS.md)** - Test requirements and acceptance criteria
- **[Development Guide](../docs/development/testing.md)** - Detailed testing implementation

---

*This testing strategy ensures the offline-first, security-focused Card Snap UI meets all business requirements while maintaining educational value for Flutter development.*
