# Test Structure & Strategy

This directory contains comprehensive tests for Card Snap UI, organized by Clean Architecture layers.

## 📁 Test Organization

```
test/
├── domain/              # Domain layer tests
│   ├── entities/        # Entity validation tests
│   └── usecases/        # Use case business logic tests
├── data/                # Data layer tests
│   ├── models/          # Data model serialization tests
│   ├── datasources/     # Data source implementation tests
│   └── repositories/     # Repository implementation tests
├── presentation/        # Presentation layer tests
│   └── widgets/         # Widget component tests
├── core/                # Core layer tests
│   └── errors/          # Error handling tests
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
// Example: Platform detection and factory delegation
test('AdaptiveWidgetFactory should delegate to platform strategy', () {
  final card = AdaptiveWidgetFactory.createCard(
    child: const Text('Test'),
    margin: const EdgeInsets.all(16),
  );
  
  expect(card, isNotNull);
  // Widget should be created without exceptions
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

## 📈 What to Test? (Testing Priorities)

### High Priority - Critical Business Logic

#### 1. Domain Layer (Business Logic)
**What to test:**
- Entity models (validation, serialization, equality)
- Use cases (business rules, error handling)
- Result pattern (success/failure flows)

**Why it matters:**
- Core application logic
- No Flutter dependencies, easy to test
- Direct impact on functionality

**Example:**
```dart
test('AddCard use case should validate required fields', () {
  final request = AddCardRequest(
    name: 'Test Card',
    storeName: 'Test Store',
    barcodeData: '123456',
  );
  expect(request.isValid, isTrue);
});
```

#### 2. Core Layer (Foundation)
**What to test:**
- Exception types (Domain, Data, Network, Security, Localization)
- Result<T> pattern (Success/Failure handling)
- Error handling flows

**Why it matters:**
- Cross-cutting concerns used everywhere
- Fundamental data types
- Critical for error propagation

**Example:**
```dart
test('Result should handle success correctly', () {
  final result = Result.success('data');
  expect(result.isSuccess, isTrue);
  expect(result.dataOrNull, equals('data'));
});
```

#### 3. Data Layer (Persistence)
**What to test:**
- Model serialization/deserialization
- Data source CRUD operations
- Repository integration (domain ↔ data mapping)
- Model ↔ Domain conversion

**Why it matters:**
- Offline-first architecture critical
- Wrong serialization = data loss
- Correctness of mapping between layers

**Example:**
```dart
test('LoyaltyCardModel should serialize to JSON correctly', () {
  final model = LoyaltyCardModel(/* ... */);
  final json = model.toJson();
  expect(json['name'], model.name);
});
```

### Medium Priority - Platform-Specific Logic

#### 4. Platform Detection
**What to test:**
- Platform detection logic
- Factory delegation to correct strategy
- Strategy selection logic

**Why it matters:**
- Correct UI selection for platform
- Critical for cross-platform compatibility

**Example:**
```dart
test('PlatformDetector should return valid platform', () {
  final theme = PlatformDetector.getCurrentTheme();
  expect(PlatformTheme.values, contains(theme));
});
```

#### 5. Repository Integration
**What to test:**
- Repository with real data source
- CRUD operations end-to-end
- Search functionality
- Error handling

**Why it matters:**
- Real integration between repository + datasource
- Correctness of transformations

**Example:**
```dart
test('should add and retrieve card', () async {
  final card = createTestCard();
  await repository.addCard(card);
  
  final result = await repository.getCardById(card.id);
  expect(result.isSuccess, isTrue);
  expect(result.dataOrNull, equals(card));
});
```

### Lower Priority - UI and Integration

#### 6. Widget Tests (UI Rendering)
**What to test:**
- Widget rendering
- User interactions (tap, scroll)
- Empty states, loading states

**Why it matters:**
- UI behavior critical for UX
- Verification of integration with domain/data layers

**Example:**
```dart
testWidgets('should render card tile with all fields', (tester) async {
  final card = createTestCard();
  
  await tester.pumpWidget(
    MaterialApp(
      home: CardTile(card: card, onTap: () {}),
    ),
  );
  
  expect(find.text(card.name), findsOneWidget);
  expect(find.text(card.storeName), findsOneWidget);
});
```

#### 7. Integration Tests (End-to-End)
**What to test:**
- Complete user journeys
- Add card flow
- Search cards flow
- Offline behavior

**Why it matters:**
- Tests real user journeys
- Verifies integration between layers

## 🎓 What NOT to Test (YAGNI Principle)

### Don't Test

1. **UI Styling (margins, colors, borders)**
   - This is configuration, not logic
   - Values from Material Design 3 / iOS HIG
   - Documented in comments

2. **Flutter's Built-in Widgets**
   - Material/Cupertino widgets are tested by Flutter team
   - We only configure existing widgets

3. **Pure Configuration**
   - Factory delegations (test core logic, not delegation)
   - Strategy selection (test business rules, not selection)

## 🔶 Angular Developer Comparison

**What Angular developers test:**

```typescript
// ✅ Test business logic
describe('CardService', () => {
  it('should add card with validation', () => {
    // ...
  });
});

// ✅ Test data services  
describe('HttpClient', () => {
  it('should serialize/deserialize', () => {
    // ...
  });
});

// ✅ Test component behavior
describe('CardTileComponent', () => {
  it('should emit tap event', () => {
    // ...
  });
});

// ❌ DON'T test
describe('Angular Material Card', () => {
  it('should have correct padding', () => {
    // ❌ This is Angular Material's responsibility
  });
});
```

**Flutter equivalent:**

```dart
// ✅ Test business logic
test('AddCard use case should validate request', () {});

// ✅ Test data models
test('LoyaltyCardModel should serialize correctly', () {});

// ✅ Test widgets
testWidgets('CardTile should render correctly', () {});

// ❌ DON'T test
test('Material Card should have 16dp padding', () {
  // ❌ This is Flutter's responsibility
});
```

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

## 🔗 Related Documentation

- **[Architecture Guide](../ARCHITECTURE.md)** - Testing strategy and patterns
- **[Business Requirements](../BUSINESS.md)** - Test requirements and acceptance criteria
- **[Development Guide](../docs/development/testing.md)** - Detailed testing implementation

---

*This testing strategy ensures the offline-first, security-focused Card Snap UI meets all business requirements while maintaining educational value for Flutter development.*
