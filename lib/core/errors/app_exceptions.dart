/// 🔶 Core Error Handling
///
/// Centralized error handling and custom exceptions.
/// Similar to Angular's ErrorHandler service and custom error classes.
///
/// In Angular, you'd have:
/// ```typescript
/// export class AppErrorHandler implements ErrorHandler {
///   handleError(error: any): void {
///     console.error('Application error:', error);
///     // Send to logging service
///   }
/// }
/// ```
///
/// In Flutter/Dart, we use custom exceptions and error handling.
library core.errors;

/// Base application exception
/// 🔹 All custom exceptions extend this for consistent error handling
abstract class AppException implements Exception {
  /// Error message for display to user
  final String message;

  /// Technical details for debugging
  final String? technicalDetails;

  /// Trace ID for correlating errors across layers
  final String? traceId;

  const AppException(this.message, {this.technicalDetails, this.traceId});

  @override
  String toString() => 'AppException: $message';
}

/// Domain layer exceptions
/// 🔹 Business logic errors (validation, business rules)
class DomainException extends AppException {
  const DomainException(super.message, {super.technicalDetails, super.traceId});
}

/// Data layer exceptions
/// 🔹 Data access errors (network, database, serialization)
class DataException extends AppException {
  const DataException(super.message, {super.technicalDetails, super.traceId});
}

/// Network-specific exceptions
/// 🔹 Offline-first approach requires specific network error handling
class NetworkException extends DataException {
  /// Whether the device is currently offline
  final bool isOffline;

  const NetworkException(
    super.message, {
    super.technicalDetails,
    super.traceId,
    this.isOffline = false,
  });
}

/// Encryption and security exceptions
/// 🔹 Critical for offline wallet with encrypted storage
class SecurityException extends AppException {
  const SecurityException(
    super.message, {
    super.technicalDetails,
    super.traceId,
  });
}

/// Localization exceptions
/// 🔹 Multilingual support requires proper error handling
class LocalizationException extends AppException {
  const LocalizationException(
    super.message, {
    super.technicalDetails,
    super.traceId,
  });
}

/// Result wrapper for error handling
/// 🔹 Similar to TypeScript's Result<T, E> pattern or Rust's Result
/// 🔹 Forces explicit error handling (no silent failures)
sealed class Result<T> {
  const Result();

  /// Success result with data
  const factory Result.success(T data) = Success<T>;

  /// Failure result with error
  const factory Result.failure(AppException error) = Failure<T>;

  /// Check if result is successful
  bool get isSuccess => this is Success<T>;

  /// Check if result is failure
  bool get isFailure => this is Failure<T>;

  /// Get data if successful, null otherwise
  T? get dataOrNull => isSuccess ? (this as Success<T>).data : null;

  /// Get error if failed, null otherwise
  AppException? get errorOrNull =>
      isFailure ? (this as Failure<T>).error : null;
}

/// Success result implementation
final class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

/// Failure result implementation
final class Failure<T> extends Result<T> {
  final AppException error;

  const Failure(this.error);
}
