# Data Layer

The **Data Layer** handles all data sources and persistence. This is similar to Angular's data services and HTTP interceptors, but with offline-first capabilities.

## Angular Analogy
In Angular, you'd have:
- `HttpClient` for API calls
- `HttpInterceptor` for request/response transformation
- Services like `UserService`, `ProductService` that fetch data
- `LocalStorageService` for client-side persistence

## Flutter/Dart Equivalent
- **Repositories** (`data/repositories/`) - implement domain interfaces
- **Data sources** (`data/datasources/`) - API, local database, cache
- **Models** (`data/models/`) - JSON serialization and data transfer objects
- **Mappers** (`data/mappers/`) - convert between domain and data models

## Repository Patterns
Following ARCHITECTURE.md §9, we implement three patterns:

### 1. API Repository
```dart
/// Remote data via HTTP - like Angular HttpClient calls
class ApiCardRepository implements CardRepository {
  final Dio dio; // Similar to Angular's HttpClient
  // ...
}
```

### 2. Local Database Repository  
```dart
/// Offline-first persistence - like Angular LocalStorageService
class LocalCardRepository implements CardRepository {
  final HiveInterface hive; // Local database
  // ...
}
```

### 3. Hybrid Repository
```dart
/// API + Local cache - like Angular service with caching
class CachedCardRepository implements CardRepository {
  final ApiCardRepository api;
  final LocalCardRepository cache;
  // Graceful degradation when offline
}
```

## Key Principles
- **Offline-first** - all operations work without network
- **Encrypted storage** - sensitive data encrypted at rest (AES-256-GCM)
- **Repository pattern** - abstract data sources behind interfaces
- **Error resilience** - graceful fallback when APIs fail

## Files Structure
```
data/
├── datasources/       # API, local DB, cache implementations
├── models/           # JSON serialization models
├── mappers/          # Domain ↔ Data model conversion
└── repositories/     # Repository implementations
```
