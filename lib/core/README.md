# Core Layer

The **Core Layer** contains cross-cutting concerns that support the entire application. Think of this as Angular's `core` module that provides shared services, utilities, and infrastructure.

## Angular Analogy
In Angular, you'd have:
- `CoreModule` with `HttpClient`, `LoggerService`, `ErrorHandler`
- Shared utilities like `DatePipe`, `CurrencyPipe`
- Constants and enums used across features

## Flutter/Dart Equivalent
- **Platform adapters** (`core/platform/`) - handle Android/iOS differences
- **Logging infrastructure** (`core/logging/`) - structured logging with trace IDs
- **Error handling** (`core/errors/`) - centralized error management
- **Constants** (`core/constants/`) - app-wide constants and enums
- **Extensions** (`core/extensions/`) - Dart extensions for common operations

## Key Principles
- **Pure Dart** - no Flutter imports in core utilities
- **Platform abstraction** - hide platform-specific code behind interfaces
- **Observability first** - every operation should be traceable
- **Offline-first** - core services work without network connectivity

## Files Structure
```
core/
├── constants/          # App-wide constants (like Angular's environment files)
├── errors/            # Error handling and custom exceptions
├── extensions/        # Dart extensions (like Angular pipes)
├── logging/          # Structured logging infrastructure
├── platform/         # Platform-specific adapters
└── utils/            # Pure utility functions
```
