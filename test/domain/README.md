# Domain Layer Tests

Tests for pure business logic and domain entities.

## 🎯 Test Focus

- **Entity validation** - Business rules and data integrity
- **Use case logic** - Business operations and workflows
- **Repository interfaces** - Contract validation
- **Value objects** - Immutable data containers

## 📁 Test Structure

```
test/domain/
├── entities/            # Entity validation tests
│   ├── card_test.dart   # Card entity business rules
│   └── README.md        # Entity testing guidelines
├── usecases/            # Use case business logic tests
│   ├── add_card_test.dart # AddCard use case tests
│   └── README.md        # Use case testing guidelines
├── repositories/        # Repository interface tests
│   ├── card_repository_test.dart # Repository contract tests
│   └── README.md        # Repository testing guidelines
└── value_objects/       # Value object tests
    └── README.md        # Value object testing guidelines
```

## 🧪 Test Examples

### Entity Tests
```dart
// test/domain/entities/card_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/domain/entities/card.dart';

void main() {
  group('Card Entity', () {
    test('should validate required fields', () {
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
    
    test('should reject empty name', () {
      final card = Card(
        id: 'test-id',
        name: '', // Empty name
        storeName: 'Test Store',
        barcodeData: '123456789',
        format: BarcodeFormat.qrCode,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      expect(card.isValid, isFalse);
    });
  });
}
```

### Use Case Tests
```dart
// test/domain/usecases/add_card_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:card_snap_ui/domain/usecases/add_card.dart';
import 'package:card_snap_ui/domain/repositories/card_repository.dart';

class MockCardRepository extends Mock implements CardRepository {}

void main() {
  group('AddCard Use Case', () {
    late AddCard useCase;
    late MockCardRepository mockRepository;
    
    setUp(() {
      mockRepository = MockCardRepository();
      useCase = AddCard(mockRepository);
    });
    
    test('should add valid card successfully', () async {
      // Arrange
      final request = AddCardRequest(
        name: 'Test Card',
        storeName: 'Test Store',
        barcodeData: '123456789',
        format: BarcodeFormat.qrCode,
      );
      
      when(() => mockRepository.getAllCards())
          .thenAnswer((_) async => Result.success([]));
      when(() => mockRepository.addCard(any()))
          .thenAnswer((_) async => Result.success(createTestCard()));
      
      // Act
      final result = await useCase.execute(request);
      
      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull?.name, equals('Test Card'));
    });
  });
}
```

## 🎓 Educational Focus

### Angular/TypeScript Analogies
- **Entity Tests** ≈ Angular model validation tests
- **Use Case Tests** ≈ Angular service method tests
- **Repository Tests** ≈ Angular service interface tests

### Business Context
- **Offline-first** - All tests work without network
- **Security** - Validate encryption and data protection
- **Multilingual** - Test i18n support where applicable

## 📋 TODO: Implementation

1. **Card entity tests** - Validation rules and business logic
2. **AddCard use case tests** - Business operation validation
3. **Repository interface tests** - Contract compliance
4. **Value object tests** - Immutable data validation

---

*Domain tests ensure business logic correctness and maintain educational value for Flutter development.*
