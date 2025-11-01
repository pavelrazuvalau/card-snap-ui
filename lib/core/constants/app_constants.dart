/// 🔶 Core Constants
///
/// Application-wide constants and configuration values.
/// Similar to Angular's environment files (environment.ts, environment.prod.ts).
///
/// In Angular, you'd have:
/// ```typescript
/// export const environment = {
///   production: false,
///   apiUrl: 'https://api.example.com',
///   appName: 'Card Snap Wallet'
/// };
/// ```
///
/// In Flutter/Dart, we use static const for compile-time constants.
///
/// See STYLEGUIDE.md#32-const-constructors (§3.2) for const declaration guidelines and best practices.
library core.constants;

/// Application metadata constants
/// 🔹 `const` = compile-time constant, similar to TypeScript `const` but more strict
class AppConstants {
  /// Application name - displayed in UI and logs
  static const String appName = 'Card Snap Wallet';

  /// Application version - follows SemVer (see ARCHITECTURE.md §20)
  static const String appVersion = '0.0.1';

  /// Minimum supported Android API level
  /// 🧠 Android API 23+ = Android 6.0+ (covers 95%+ of devices)
  static const int minAndroidApi = 23;

  /// Minimum supported iOS version
  /// 🧠 iOS 14+ = iPhone 6s and newer (covers 95%+ of devices)
  static const String minIosVersion = '14.0';
}

/// Encryption and security constants
/// 🔹 Security-first approach for offline wallet data
class SecurityConstants {
  /// Encryption algorithm for local storage
  /// 🧠 AES-256-GCM provides authenticated encryption (confidentiality + integrity)
  static const String encryptionAlgorithm = 'AES-256-GCM';

  /// Key derivation function for password-based encryption
  static const String keyDerivationFunction = 'PBKDF2';

  /// Number of iterations for key derivation (security vs performance trade-off)
  /// 🧠 100,000 iterations = ~100ms on modern devices, secure against brute force
  static const int keyDerivationIterations = 100000;
}

/// Localization constants
/// 🔹 Primary languages: ru/en/uk/pl (from BUSINESS.md §1)
/// 🔹 Extended languages: de/fr/es/it/nl/sv
class LocalizationConstants {
  /// Primary supported languages (must-have for v0.0.1)
  static const List<String> primaryLanguages = ['ru', 'en', 'uk', 'pl'];

  /// Extended supported languages (nice-to-have)
  static const List<String> extendedLanguages = [
    'de',
    'fr',
    'es',
    'it',
    'nl',
    'sv',
  ];

  /// Default language fallback
  static const String defaultLanguage = 'en';

  /// All supported languages combined
  static const List<String> allLanguages = [
    ...primaryLanguages,
    ...extendedLanguages,
  ];
}

/// Network and offline constants
/// 🔹 Offline-first approach (from BUSINESS.md §1)
class NetworkConstants {
  /// Request timeout for API calls (milliseconds)
  /// 🧠 30 seconds balances UX vs reliability
  static const int requestTimeoutMs = 30000;

  /// Cache duration for offline data (hours)
  /// 🧠 24 hours = reasonable offline window for loyalty cards
  static const int cacheDurationHours = 24;

  /// Maximum retry attempts for failed requests
  static const int maxRetryAttempts = 3;
}
