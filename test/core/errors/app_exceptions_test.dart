/// 🔶 Core Error Handling Tests
///
/// Comprehensive tests for error handling and Result pattern.
///
/// The Result pattern is similar to TypeScript's Result<T, E> or Rust's Result type.
/// It forces explicit error handling (no silent failures).
///
/// In Angular, you'd typically use RxJS Observable error handling:
/// ```typescript
/// this.service.getData().subscribe({
///   next: (data) => console.log(data),
///   error: (error) => console.error(error)
/// });
/// ```
///
/// In Flutter/Dart, we use the Result wrapper for explicit success/failure handling.

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/core/errors/app_exceptions.dart';

void main() {
  group('AppException', () {
    test('should create exception with message via DomainException', () {
      // 🔹 AppException is abstract, so use concrete implementation
      const exception = DomainException('Test error');
      expect(exception.message, 'Test error');
      expect(exception.technicalDetails, isNull);
      expect(exception.traceId, isNull);
    });

    test(
      'should create exception with technical details via DomainException',
      () {
        // 🔹 AppException is abstract, so use concrete implementation
        const exception = DomainException(
          'User-facing message',
          technicalDetails: 'Technical stack trace',
          traceId: 'trace-123',
        );
        expect(exception.message, 'User-facing message');
        expect(exception.technicalDetails, 'Technical stack trace');
        expect(exception.traceId, 'trace-123');
      },
    );

    test('should return meaningful string representation', () {
      const exception = DomainException('Test error');
      expect(exception.toString(), 'AppException: Test error');
    });
  });

  group('DomainException', () {
    test('should create domain exception', () {
      const exception = DomainException(
        'Business rule violation',
        technicalDetails: 'Validation failed',
        traceId: 'trace-456',
      );
      expect(exception.message, 'Business rule violation');
      expect(exception.technicalDetails, 'Validation failed');
      expect(exception.traceId, 'trace-456');
    });
  });

  group('DataException', () {
    test('should create data exception', () {
      const exception = DataException(
        'Database error',
        technicalDetails: 'SQL error: constraint violation',
        traceId: 'trace-789',
      );
      expect(exception.message, 'Database error');
      expect(exception.technicalDetails, 'SQL error: constraint violation');
      expect(exception.traceId, 'trace-789');
    });
  });

  group('NetworkException', () {
    test('should create network exception with offline flag', () {
      const exception = NetworkException('Connection failed', isOffline: true);
      expect(exception.message, 'Connection failed');
      expect(exception.isOffline, true);
    });

    test('should create network exception without offline flag', () {
      const exception = NetworkException('Timeout error');
      expect(exception.message, 'Timeout error');
      expect(exception.isOffline, false);
    });
  });

  group('SecurityException', () {
    test('should create security exception', () {
      const exception = SecurityException(
        'Encryption failed',
        technicalDetails: 'Key derivation error',
      );
      expect(exception.message, 'Encryption failed');
      expect(exception.technicalDetails, 'Key derivation error');
    });
  });

  group('LocalizationException', () {
    test('should create localization exception', () {
      const exception = LocalizationException('Missing translation');
      expect(exception.message, 'Missing translation');
    });
  });

  group('Result Wrapper', () {
    group('Success Result', () {
      test('should create success result', () {
        // 🔹 Test Result.success factory constructor
        const result = Result.success('test data');
        expect(result.isSuccess, isTrue);
        expect(result.isFailure, isFalse);
      });

      test('should return data for success result', () {
        const result = Result.success(42);
        expect(result.dataOrNull, 42);
        expect(result.errorOrNull, isNull);
      });

      test('should handle complex data types', () {
        final data = {'key': 'value', 'number': 123};
        final result = Result.success(data);
        expect(result.dataOrNull, data);
        expect(result.dataOrNull?['key'], 'value');
      });
    });

    group('Failure Result', () {
      test('should create failure result', () {
        // 🔹 Test Result.failure factory constructor
        const error = DomainException('Validation failed');
        final result = Result.failure(error);
        expect(result.isSuccess, isFalse);
        expect(result.isFailure, isTrue);
      });

      test('should return error for failure result', () {
        const error = DataException('Database error');
        final result = Result.failure(error);
        expect(result.dataOrNull, isNull);
        expect(result.errorOrNull, error);
      });

      test('should handle different exception types', () {
        const securityError = SecurityException('Encryption failed');
        final result = Result.failure(securityError);
        expect(result.errorOrNull, securityError);
        expect(result.errorOrNull?.message, 'Encryption failed');
      });
    });

    group('Result Properties', () {
      test('isSuccess should be true for success', () {
        const result = Result.success('data');
        expect(result.isSuccess, isTrue);
      });

      test('isSuccess should be false for failure', () {
        const result = Result.failure(const DomainException('Error'));
        expect(result.isSuccess, isFalse);
      });

      test('isFailure should be false for success', () {
        const result = Result.success('data');
        expect(result.isFailure, isFalse);
      });

      test('isFailure should be true for failure', () {
        const result = Result.failure(const DomainException('Error'));
        expect(result.isFailure, isTrue);
      });

      test('dataOrNull should return data for success', () {
        const result = Result.success('test');
        expect(result.dataOrNull, 'test');
      });

      test('dataOrNull should return null for failure', () {
        const result = Result.failure(const DomainException('Error'));
        expect(result.dataOrNull, isNull);
      });

      test('errorOrNull should return null for success', () {
        const result = Result.success('data');
        expect(result.errorOrNull, isNull);
      });

      test('errorOrNull should return error for failure', () {
        const error = DomainException('Validation failed');
        final result = Result.failure(error);
        expect(result.errorOrNull, error);
      });
    });

    group('Result Pattern Examples', () {
      test('should handle success flow', () {
        // 🔹 Example: Simulating a successful operation
        // Similar to Angular's Observable success path
        Result<String> fetchData() => const Result.success('data');

        final result = fetchData();
        if (result.isSuccess) {
          expect(result.dataOrNull, 'data');
        }
      });

      test('should handle failure flow', () {
        // 🔹 Example: Simulating a failed operation
        // Similar to Angular's Observable error path
        Result<String> fetchData() =>
            const Result.failure(DataException('Network timeout'));

        final result = fetchData();
        if (result.isFailure) {
          expect(result.errorOrNull?.message, 'Network timeout');
        }
      });

      test('should chain multiple operations', () {
        // 🔹 Example: Chaining Result operations
        // Similar to Angular's pipe() operator

        Result<int> parseString(String input) {
          try {
            return Result.success(int.parse(input));
          } catch (e) {
            return Result.failure(DomainException('Invalid number: $e'));
          }
        }

        // Successful chain
        final successResult = parseString('123');
        expect(successResult.isSuccess, isTrue);
        expect(successResult.dataOrNull, 123);

        // Failed chain
        final failureResult = parseString('invalid');
        expect(failureResult.isFailure, isTrue);
      });
    });
  });
}
