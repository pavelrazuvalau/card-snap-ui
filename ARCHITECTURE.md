# Card Snap UI Architecture — Educational AI-Assisted Edition

This document defines the **production-ready yet educational architecture** for the Card Snap UI Flutter application.  
It is designed for an **Angular/TypeScript developer exploring Flutter with AI copilots**, where every artifact explains *how* and *why* decisions were made. AI tools such as **Cursor** and **GitKraken MCP** act as teaching partners, turning the repository into a self-documenting textbook.

Humans start in `README.md` for the high-level overview; this file is the canonical deep dive into architectural choices, testing, documentation, and repository governance.

---

## 1. Purpose

This architecture ensures consistency in code, commits, and documentation across all contributors, including AI agents. It covers:

- Structural patterns (clean architecture, layering, state management).
- Testing strategy and CI/CD automation.
- AI-assisted documentation expectations.
- Repository and version-control policies (GitFlow, Conventional Commits).
- Observability and traceability practices.

> **Guiding principle:** Depth of understanding outweighs speed. Every file, comment, and commit should teach humans *and* AI.  
> **Critical reference:** All business requirements, functional specifications, user stories, data models, and feature priorities are defined in `BUSINESS.md`. This document serves as the **primary source of truth** for business rules. Architecture decisions must align with business requirements outlined in `BUSINESS.md`.  
> **Code style standards:** All coding style standards, Dart/Flutter best practices, and syntax explanations are defined in `STYLEGUIDE.md`. This document serves as the **single source of truth** for code style.

---

## 2. Architectural Principles

| Principle | Description |
|-----------|-------------|
| **Clean Architecture** | Separation of concerns across `core`, `data`, `domain`, and `presentation`. |
| **SOLID** | Modular, testable, and extensible code. |
| **Design Patterns** | Factory, Repository, Use Cases patterns for modularity and testability. |
| **Reactive by Design** | Streams and observable state, mirroring RxJS mental models. |
| **Transparency** | Each file explains intent, syntax, and trade-offs. |
| **Self-Documentation** | Comments and docs remain the living source of truth. |
| **Cross-Ecosystem Learning** | Dart patterns explained using TypeScript/Angular analogies. |
| **DocOps Approach** | Documentation is part of the delivery lifecycle (dartdoc + mkdocs). |
| **AI-Assisted Workflow** | Cursor + GitKraken MCP manage code, docs, and Git in tandem. |
| **Flutter-First** | Code follows Flutter idiomatic practices only; Angular concepts used only for educational analogies in documentation |

### 2.1 Flutter-First Principle

**See `STYLEGUIDE.md` §1.1 for complete Flutter-First Principle guidelines.**

Code must be pure, idiomatic Flutter. Angular analogies exist only in documentation/comments for teaching purposes.

---

## 3. Core Architectural Goals

- Ship a maintainable Android + iOS Flutter application **that fulfills all business requirements defined in `BUSINESS.md`**.
- Keep design clean, reactive, testable, and loosely coupled.
- Automate CI/CD from linting to store-ready builds.
- Provide structured logging and observability from day one.
- Maintain flexibility for experiments without disrupting learning flow.
- Prefer **loose coupling over tight coupling**, especially in domain use cases; depend on abstractions to keep the architecture adaptable.
- **Ensure all feature implementations satisfy acceptance criteria and business rules from `BUSINESS.md` §§4–5.**

---

## 4. Syntax Comparison (Angular → Flutter / Dart)

**See `STYLEGUIDE.md` §2 for complete syntax comparisons and Dart language explanations with Angular/TypeScript analogies.**

---

## 5. Architecture & Design Patterns

### 5.1 Adaptive Widget Factory

The application uses adaptive widget factory for cross-platform UI adaptation, similar to Angular's platform detection service. The implementation uses a **Facade pattern** that delegates to specialized factories for each widget type.

**Architecture:** `AdaptiveWidgetFactory` (facade) → `AdaptiveCardFactory` (specialized) → `StrategyFactory` → `Strategy` (platform-specific)

**Architecture:** `AdaptiveWidgetFactory` (facade) → `AdaptiveCardFactory` (specialized) → `StrategyFactory` → `Strategy` (platform-specific)

```dart
/// 🔶 Adaptive Widget Factory: Platform-Specific UI Adaptation
/// Main facade that delegates to specialized factories for each widget type.
class AdaptiveWidgetFactory {
  static PlatformTheme getCurrentTheme() => PlatformDetector.getCurrentTheme();
  
  static Widget createCard({required Widget child, ...}) {
    return AdaptiveCardFactory.createCard(child: child, ...);
  }
}
```

### 5.2 Key Design Patterns Applied

**Facade Pattern** - `AdaptiveWidgetFactory` serves as a unified interface (facade) for creating adaptive widgets. It delegates to specialized factories (`AdaptiveCardFactory`, `AdaptiveScaffoldFactory`, etc.) without exposing the complexity of the underlying implementation.

**Factory Pattern** - Each widget type has its own specialized factory (`AdaptiveCardFactory`, `AdaptiveScaffoldFactory`, `AdaptiveButtonFactory`, etc.) that creates platform-specific components. These factories are self-contained and don't depend on a central registry.

**Strategy Pattern** - Platform-specific implementations are encapsulated in strategy classes (`MaterialCardStrategy`, `CupertinoCardStrategy`, etc.). Each widget has its own strategy files living alongside its factory in the same folder. This follows co-location principle and improves maintainability. The strategy selection happens via `StrategySelector` which provides centralized platform detection and eliminates duplication across factories. Each factory delegates directly to `StrategySelector.getStrategyForCurrentPlatform()` and `StrategySelector.getStrategyForTheme()` methods.

**StrategySelector Pattern** - Centralizes platform detection and strategy selection logic. All factories delegate to `StrategySelector` to avoid code duplication. This follows DRY principle by implementing the selection logic once and reusing it across all factory classes. Each factory only needs to specify its specific strategy constructors (Cupertino vs Material implementations).

**Example:**
```dart
class AppBarStrategyFactory {
  static AppBarStrategy getStrategy() =>
      StrategySelector.getStrategyForCurrentPlatform(
        () => CupertinoAppBarStrategy(),
        () => MaterialAppBarStrategy(),
      );
}
```

**Benefits:**
- DRY compliance: Platform selection logic implemented once in `StrategySelector`
- Consistent API: All factories have identical `getStrategy()` and `getStrategyForTheme()` methods
- Easy to add new widgets: Just create folder with factory + strategy, no central registry changes needed
- Flutter-idiomatic: Uses arrow functions and direct delegation patterns

**Adaptive Root App Widget** - The application root uses `AdaptiveAppFactory.createApp()` to switch between MaterialApp and CupertinoApp based on platform. Strategies create their own themes internally—complete encapsulation.

**Style Guide Compliance** - All strategy implementations must follow official platform design guidelines. See `STYLEGUIDE.md` §7 for Material Design 3 and iOS HIG compliance requirements.

**Repository Pattern** - Abstracts data access layer with `CardRepository` interface and implementations. Similar to Angular's service layer that abstracts HTTP calls.

**Use Cases Pattern** - Encapsulates business logic in dedicated use case classes. Similar to Angular's service methods that coordinate between services and components.

**Dependency Injection** - Domain layer depends on abstractions (repository interfaces) rather than concrete implementations, ensuring loose coupling. Use Flutter DI solutions (`get_it`, `provider`) for business logic (repositories, use cases, services), but NOT for UI factories.

**Best Practices & File Organization** - See `STYLEGUIDE.md` §1.3 for best practices (YAGNI, DRY, KISS, SOLID) and §4 for file organization guidelines.

**SOLID Compliance**
- **Open/Closed Principle**: Each widget factory is self-contained. To add a new widget, create a new folder with factory + strategy. No central registry needs modification.
- **Single Responsibility**: Each factory creates only one widget type, each strategy implements only one platform variant.
- **Dependency Inversion**: Factories depend on strategy interfaces, not concrete implementations.

---

## 6. Project Structure

```bash
lib/
 ├── core/                    # DI, config, logging, error handling
 │   ├── constants/           # App-wide constants
 │   ├── errors/             # Error handling and exceptions
 │   └── platform/           # Platform detection and adapters
 ├── data/                    # Data sources, API clients, local storage abstractions
 │   ├── datasources/        # Data source implementations
 │   ├── models/             # Data models and DTOs
 │   └── repositories/       # Repository implementations
 ├── domain/                  # Business logic, models, use cases
 │   ├── entities/           # Domain entities
 │   ├── repositories/       # Repository interfaces
 │   └── usecases/           # Use case implementations
 ├── presentation/           # UI, state management, widgets
 │   ├── pages/              # Screen/page widgets
 │   ├── widgets/            # Reusable UI components
 │   │   └── adaptive/       # Cross-platform adaptive widgets
 │   │       ├── button/     # Button factory + strategy
 │   │       ├── card/       # Card factory + strategy
 │   │       ├── scaffold/   # Scaffold factory + strategy
 │   │       └── common/     # Shared platform types
 │   └── viewmodels/          # View models and state management
 └── main.dart               # Application entry point

test/                        # Unit & widget tests
 ├── unit/                   # Unit tests for domain logic
 ├── widget/                 # Widget tests
 ├── integration/            # Integration tests
 └── mocks/                  # Mock implementations

integration_test/            # E2E flows with mock backend
infra/                      # CI/CD, fastlane, observability scripts
docs/                       # Markdown + generated documentation
.github/workflows/           # CI pipelines
```

> Keep the folder structure stable. Prototype architecture ideas in feature branches or feature flags rather than reshuffling directories.

---

### 6.1 Offline-First Data Flow

Card Snap UI follows an **offline-first architecture** where all core functionality works without network connectivity. The data flow is designed to prioritize local storage and encryption while maintaining extensibility for future cloud sync capabilities.

#### Data Flow Architecture

```
┌──────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  UI Components (Widgets, Pages)                         │ │
│  │  - Card List Widget                                     │ │
│  │  - Add Card Form                                        │ │
│  │  - Backup/Restore UI                                    │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────┬────────────────────────────────────┘
                          │
                          ▼
┌──────────────────────────────────────────────────────────────┐
│                      Domain Layer                            │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Entities                                               │ │
│  │  - LoyaltyCard                                          │ │
│  │  - (Store, BackupArchive, Facet - planned v1.0+)        │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Repository Interfaces                                  │ │
│  │  - CardRepository                                       │ │
│  │  - (StoreRepository, BackupRepository, StorageProvider) │ │
│  │    planned v1.0+                                        │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Use Cases                                              │ │
│  │  - AddCardUseCase                                       │ │
│  │  - (SearchStoresUseCase, BackupUseCases) planned v1.0+  │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────┬────────────────────────────────────┘
                          │
                          ▼
┌──────────────────────────────────────────────────────────────┐
│                       Data Layer                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Local Implementation (OFFLINE-FIRST)                   │ │
│  │  - SQLite + SQLCipher (encrypted storage)               │ │
│  │  - Hive/Isar (NoSQL alternative)                        │ │
│  │  - Encrypted file system access                         │ │
│  │  - All data encrypted at rest (AES-256-GCM)             │ │
│  └─────────────────────────────────────────────────────────┘ │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  Future Cloud Implementation (v1.0+)                    │ │
│  │  - Google Drive StorageProvider                         │ │
│  │  - iCloud StorageProvider                               │ │
│  │  - Dropbox StorageProvider                              │ │
│  │  - Hybrid Repository (local + cloud)                    │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────┬────────────────────────────────────┘
                          │
                          ▼
┌──────────────────────────────────────────────────────────────┐
│                    Platform Layer                            │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │  - Android Keystore (key storage)                       │ │
│  │  - iOS Keychain (key storage)                           │ │
│  │  - Secure Enclave (hardware-backed keys)                │ │
│  │  - Biometric authentication (FaceID/TouchID)            │ │
│  └─────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```

#### Key Architectural Decisions

1. **Offline-First Storage (MVP):**
   - All card data stored locally with encryption
   - No network dependency for core operations
   - Fast access (< 200ms card rendering)
   - Secure key management via platform APIs

2. **Backup Strategies (MVP):**
   - **QR-based backup:** Generate encrypted QR code for offline transfer
   - **Archive export:** Create encrypted `.zip` files for file-based transfer
   - **Future cloud sync:** Extensible `StorageProvider` interface for v1.0+

3. **Extensibility (Future):**
   - Repository pattern allows swapping implementations
   - `StorageProvider` interface ready for cloud integration
   - Hybrid repositories can merge local + cloud data
   - No core refactoring needed when adding cloud sync

4. **Privacy-First Design:**
   - All encryption happens on-device
   - Keys never leave the device (except in user-exported backups)
   - No cloud uploads without explicit user consent
   - GDPR-compliant by default

#### Domain Entity Structure

The domain layer currently includes the core entity (see `BUSINESS.md` section 2 for detailed requirements):

- **LoyaltyCard** (`lib/domain/entities/card.dart`)
  - Core card entity with barcode data, metadata, timestamps
  - Supports multiple barcode formats (QR, Code128, EAN-13, etc.)
  - Pure Dart, no Flutter imports (domain layer principle)

**Future entities** (planned for v1.0+) to be added as development progresses:
- **Store** - Represents merchant/store locations with location data, barcode format support, deep link info
- **BackupArchive** - Encapsulates encrypted backup data with schema versioning and metadata
- **Facet** - Search facets for filtering stores (Angular Material chip-style interface)
- **StorageProvider** - Abstract interface for cloud sync providers (Google Drive, iCloud, Dropbox)

For detailed business requirements, see `BUSINESS.md` sections 2.1 (Baseline Features), 2.2 (Enhanced Features), and 2.3 (Future Scope).

---

## 7. Key Technologies

| Category | Tools / Packages | Notes |
|----------|------------------|-------|
| State Management | `flutter_bloc` or `riverpod` | Reactive store similar to NgRx. |
| Dependency Injection | `get_it` (with `injectable` optional) | Declarative service locator. |
| Networking | `dio` (+ `retrofit`) | HTTP client with interceptors and typed clients. |
| Logging | `logger` + OTLP sink | JSON logs routed to OpenTelemetry. |
| Testing | `flutter_test`, `mocktail`, `integration_test` | Core + UI + E2E coverage. |
| Observability | OTel Collector + OpenSearch | Unified traces and dashboards. |
| CI/CD | GitHub Actions | Lint → Test → Coverage → Build. |
| Localization | Flutter gen_l10n (`intl`, `flutter_localizations`) | Offline ARB-based translations. |

### 7.1 pubspec.yaml Baseline

When bootstrapping from scratch, populate `pubspec.yaml` with these minimum dependencies and dev dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.0        # or riverpod if preferred
  get_it: ^7.6.0
  dio: ^5.4.0
  retrofit: ^4.0.0
  logger: ^2.0.2
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  freezed: ^2.4.7
  json_serializable: ^6.8.0
  mocktail: ^1.0.0
  integration_test:
    sdk: flutter
  very_good_analysis: ^5.1.0   # or `flutter_lints` if preferred

# 🔶 Localization
# Use Flutter's built-in gen_l10n with ARB files stored locally for offline-first.
# Languages for MVP: en, ru, uk, pl.
# Configuration lives in `l10n.yaml`; ARB files in `lib/l10n/`.
```

- Add `analysis_options.yaml` referencing the chosen lint package (e.g., `include: package:very_good_analysis/analysis_options.yaml`).
- Configure code generation scripts in `tool/` as needed (`dart run build_runner build --delete-conflicting-outputs`).
- Update versions as newer stable releases become available; document rationale in `CHANGELOG.md`.

---

## 8. Cross-Platform Support Strategy

Card Snap UI must deliver identical learning and runtime value on **Android** and **iOS**. Every feature, test, and observability hook is evaluated for cross-platform parity.

| Topic | Policy | Rationale |
|-------|--------|-----------|
| **Target Platforms** | Android (API 23+), iOS (iOS 14+). | Covers modern devices while remaining installable on older hardware. |
| **Platform Neutral Code** | Business logic, repositories, and widgets default to platform-agnostic Flutter APIs. | Keeps the educational domain layer truly cross-platform. |
| **Platform Conditionals** | Encapsulate platform-specific branches inside dedicated adapters (e.g., `core/platform/`). Document with `// 🧠` comments that explain why the divergence exists. | Avoids scattering `Platform.is...` checks and preserves learnability. |
| **Device Testing** | Run widget tests for both platform themes (Material + Cupertino) when UI diverges. Run integration tests on Android emulator + iOS simulator before release. | Ensures consistent UX and surfaces platform quirks early. |
| **Build & Release** | CI/CD provides artifacts for both platforms; fastlane (or equivalent) scripts belong in `infra/`. | Reinforces the production-ready objective and keeps release steps reproducible. |
| **Dependencies** | Avoid platform-only packages unless there is no Flutter-first alternative; when required, wrap them behind abstractions and document trade-offs. | Maintains educational focus on shared architecture patterns. |
| **Style Guide Compliance** | All UI components must follow [Material Design 3](https://m3.material.io/) (Android) and [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines) (iOS). Document specific values (padding, colors, elevation) with style guide references. | Ensures platform-native look and feel, improves user experience, maintains design consistency. |

### 8.1 Platform Style Guides

**See `STYLEGUIDE.md` §7 for complete platform style guide compliance requirements (Material Design 3 and iOS HIG).**

### 8.2 Localization (Offline-First)

**See `STYLEGUIDE.md` §6 for complete localization standards, ICU message patterns, ARB file structure, and best practices.**

Card Snap UI uses Flutter gen_l10n with ARB files stored locally (`lib/l10n/`) for offline-first translations. MVP languages: en, ru, uk, pl; extended set includes de, fr, es, it, nl, sv.

---

## 9. Domain Layer Principles & Documentation

- Domain layer stays **pure Dart** (no Flutter imports).
- Depends solely on **abstract repositories** and **strategy interfaces** (Dependency Inversion).
- Favor **loose coupling**: inject interfaces into use cases, keep constructors lightweight, and avoid depending on framework-specific classes.
- Use **Strategy pattern** for business logic: different implementations can be swapped based on requirements (Local, API, Hybrid).
- Design each use case with **flexibility in mind**, allowing multiple repository implementations (API, LocalDB, Hybrid) to be swapped without rewriting business logic.
- Each use case is **unit-testable**, thoroughly commented, and explains how it maps back to Angular patterns.
- Documentation within the file states purpose, inputs, outputs, and collaborating layers.

```dart
/// 🔶 Use Case: AddCard
/// Business operation for adding a new loyalty card.
/// Similar to Angular service methods but focused on single business operations.
/// Input: AddCardRequest with card data
/// Output: Result<LoyaltyCard> with success or failure
/// Related layers:
/// - Domain: CardRepository interface
/// - Data: LocalCardRepository implementation
/// - Presentation: AddCardForm widgets
class AddCard {
  final CardRepository repository;
  
  AddCard(this.repository);

  /// Executes the use case with business validation.
  /// 🧠 Pure domain logic: no networking or UI references.
  /// 🧠 Offline-first: works without network connectivity.
  /// 🧠 Validates data and prevents duplicates before persisting.
  Future<Result<LoyaltyCard>> execute(AddCardRequest request) async {
    // Business validation
    if (!request.isValid) {
      return const Result.failure(DomainException('Invalid card data'));
    }
    
    // Check for duplicates
    final existingCards = await repository.getAllCards();
    // ... validation logic ...
    
    // Create and persist
    final card = LoyaltyCard(/* ... */);
    return await repository.addCard(card);
  }
}

### 9.1 Dependency Injection in Flutter

**See `STYLEGUIDE.md` §8.2 for complete Dependency Injection guidelines, when to use DI, Flutter DI solutions, and examples.**

Feature narratives should outline end-to-end flows and highlight caching/offline strategies. Refer to `BUSINESS.md` for specific user stories and acceptance criteria.

---

## 10. Repository Patterns & Strategy Implementation

**Goal:** Teach how different data sources interact through the same interface using Strategy pattern.

| Pattern | Description | Lesson |
|---------|-------------|--------|
| API Strategy | Remote data via Dio/HTTP | Separate domain decisions from I/O details. |
| Local Strategy | Hive/SQLite persistence | Offline-first and caching patterns. |
| Hybrid Strategy | API + Local cache | Resilience and graceful degradation. |

**Example:**
```dart
abstract class CardManagementStrategy {
  Future<Result<List<LoyaltyCard>>> getAllCards();
}

class LocalCardStrategy implements CardManagementStrategy {
  final LocalCardRepository repository;
  LocalCardStrategy(this.repository);
  
  @override
  Future<Result<List<LoyaltyCard>>> getAllCards() async {
    return repository.getAllCards(); // Fast, offline-capable
  }
}

class HybridCardStrategy implements CardManagementStrategy {
  final ApiCardRepository api;
  final LocalCardRepository cache;
  
  @override
  Future<Result<List<LoyaltyCard>>> getAllCards() async {
    try {
      final remote = await api.getAllCards();
      await cache.saveCards(remote.dataOrNull!);
      return remote;
    } catch (_) {
      return cache.getAllCards(); // Offline fallback
    }
  }
}
```

---

## 11. Testing Strategy

| Type | Purpose | Tools | Required |
|------|---------|-------|----------|
| **Unit** | Validate domain logic and pure services. | `flutter_test`, `mocktail` | ✅ |
| **Widget/UI** | Verify rendering and widget state behavior. | `flutter_test` | ✅ |
| **E2E / Integration** | Simulate user journeys with mocked backend. | `integration_test`, `http_mock_adapter` | ✅ |
| **Optional** | Golden or snapshot verification. | `golden_toolkit` | ➖ |

> Production-grade coverage = Unit + Widget + E2E. Each test includes educational assertions and comments that explain what is being verified and why.

### 11.1 Test Coverage Requirements

Card Snap UI enforces minimum test coverage thresholds per architectural layer:

| Layer | Minimum Coverage | Rationale |
|-------|------------------|-----------|
| **Domain** | 90%+ | Business logic must be bulletproof—this is the core of the application. Pure Dart code with no external dependencies makes it highly testable. |
| **Data** | 80%+ | Data operations are critical for offline-first architecture. Repository implementations must be thoroughly validated. |
| **Presentation** | 70%+ | UI behavior and state management require validation. Widget tests ensure proper rendering and user interactions. |
| **Core** | 85%+ | Cross-cutting concerns (platform detection, error handling, constants) must be reliable. |

**Verification Process:**
1. Run `flutter test --coverage` to generate coverage report
2. Review `coverage/lcov.info` for layer-specific coverage
3. Ensure minimum thresholds are met before committing
4. CI/CD pipeline enforces these thresholds (build fails if not met)

**Coverage Reporting:**
- **Local**: `coverage/lcov.info` generated after tests
- **CI/CD**: Uploaded to Codecov for tracking and visualization
- **Thresholds**: Enforced via CI pipeline—fail build if coverage drops below targets

See `test/README.md` for detailed testing strategy and coverage tracking methods.

---

## 12. CI/CD & AI Automation

- GitHub Actions enforce linting, formatting, testing, and coverage.
- Cursor and GitKraken MCP manage GitFlow branches and Conventional Commits.
- AI agents annotate CI steps with educational commentary (why the step exists).
- **Code Quality**: AI agents must follow linting best practices defined in `STYLEGUIDE.md` §3 (super parameters, const constructors, avoid redundant arguments).

See `STYLEGUIDE.md` §3 for comprehensive code quality requirements and examples.

```yaml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.x'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter format --set-exit-if-changed .
      - run: flutter analyze
      - run: flutter test --coverage
      - name: Upload coverage
        uses: codecov/codecov-action@v4
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
```

> Treat pipeline scripts as living documentation—keep comments and README links inline.

---

## 13. Observability & Trace Learning

Each user journey emits structured logs with a shared `traceId`, linking UI events, API calls, and errors.

```json
{
  "@timestamp": "2025-10-25T12:45:13.421Z",
  "service.name": "card-snap-ui",
  "trace.id": "c84a44f0-792e-4b56-b56a-1a9238c743cc",
  "lesson": "connect user journey across layers",
  "log.level": "ERROR",
  "message": "Login failed: invalid token"
}
```

> One user → one journey → one traceId → complete story. Document how each log ties back to use cases and error recovery paths.

---

## 14. Educational Comment & Documentation Policy

**See `STYLEGUIDE.md` §5 for complete comment taxonomy, documentation standards, and examples.**

**See `AGENTS.md` §4 for STYLEGUIDE.md references in code comments and discovery workflow.**

Comments are part of the architecture. AI assistants must preserve all comment layers when generating or refactoring code.

---

## 15. Documentation Integration Workflow

**DartDoc** - Generates static HTML in `/doc/api/`, surfacing `///` comments. Run `dart doc` to regenerate.

**MkDocs** - Optional documentation site. Run `pip install mkdocs mkdocs-material && mkdocs serve` to preview.

> Documentation updates are part of every feature or bugfix. Regenerate artifacts when comments or guides change.

---

## 17. AI Collaboration Workflow

- Follow the playbook in `AGENTS.md` for Observe → Plan → Execute → Review.
- Follow code style standards in `STYLEGUIDE.md` for all code changes.
- Humans use `README.md` as the entry point; AI must reconcile changes with sections in this file.
- When choices exist, surface trade-offs and seek human confirmation before deviating from architecture.

---

## 18. Repository & Version Control Policy

Repository management flows through **GitKraken MCP** integrated with Cursor:

### Responsibilities

- **Cursor**: drafts commits, manages branches, prepares pull requests, explains diffs.
- **GitKraken MCP**: enforces GitFlow, visibility, reviews, and CI integration.
- **Manual Git**: optional; ensure actions are reproducible via AI tools.

### Repository Rules

- Follow **Conventional Commits** for all commit messages.
- Protected branches: `main`, `develop`.
- Code review required before merging into `develop`.
- CI must pass before merging into `main`.

---

## 19. Conventional Commits Standard

Commit messages MUST follow [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

```
<type>[optional scope]: <description>
```

| Type | Description |
|------|-------------|
| **feat** | Introduces a new feature. |
| **fix** | Patches a bug. |
| **docs** | Documentation-only changes. |
| **style** | Formatting/wrapping without logic changes. |
| **refactor** | Restructuring without changing behavior. |
| **test** | Adds or updates tests. |
| **chore** | Tooling, dependencies, maintenance. |

Examples:

```
feat(auth): add token refresh on login
fix(devices): prevent crash when device id is null
docs(domain): explain device sync use case
refactor(ui): simplify dashboard rebuild logic
```

---

## 20. Branching Strategy

The repository follows **GitFlow**, adapted for AI-managed workflows with clear branch responsibilities and merge paths.

### 20.1 Branch Types and Responsibilities

| Branch | Purpose | Merge Target | CI/CD Behavior |
|--------|---------|--------------|----------------|
| `main` | **Stable production releases only.** Represents the latest released version. | N/A (protected branch) | On merge from `release/*`: Full release build, create GitHub Release, tag version |
| `develop` | **Active development integration branch.** Contains latest features and bugfixes merged from feature/bugfix branches. | N/A (protected branch) | On push: Nightly builds, validate CHANGELOG for nightly entries, create pre-release |
| `feature/*` | **New feature development.** One feature per branch. Examples: `feature/add-card-scanning`, `feature/offline-sync` | Merged into `develop` via PR | On push: Code quality checks (formatting, analyzer, tests, coverage) |
| `bugfix/*` | **Bug fixes and patches.** Examples: `bugfix/fix-crash-on-startup`, `bugfix/memory-leak` | Merged into `develop` via PR | On push: Code quality checks (formatting, analyzer, tests, coverage) |
| `release/*` | **Pre-release stabilization and testing.** Created before major releases for final testing. Examples: `release/1.0.0`, `release/0.1.0` | Merged into `main` via PR | On push: Full validation (CHANGELOG, tests, build), create pre-release APK for testing |
| `hotfix/*` | **Urgent production fixes.** For critical bugs that need immediate release. | Merged into both `main` and `develop` | On push: Full validation and build (future: automated hotfix workflow) |

### 20.2 Branching Workflow

#### Development Flow (Feature/Bugfix → Develop)

1. **Create feature/bugfix branch** from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b feature/add-card-scanning
   # or
   git checkout -b bugfix/fix-memory-leak
   ```

2. **Develop and test**:
   - Make changes with Conventional Commits
   - Push commits → automatic CI checks run (formatting, analyzer, tests)
   - Fix any CI failures

3. **Create Pull Request** into `develop`:
   - PR description should follow project standards
   - CI must pass (checks are automatically re-run on PR)
   - Code review required (enforced by branch protection)

4. **Merge to `develop`**:
   - After PR approval and CI pass
   - Merge triggers `develop` workflow → nightly build created
   - CHANGELOG must have nightly entry for version

#### Release Flow (Develop → Release → Main)

1. **Create release branch** from `develop`:
   ```bash
   git checkout develop
   git pull origin develop
   git checkout -b release/1.0.0
   ```
   - Update `pubspec.yaml` version to target release (e.g., `1.0.0`)
   - Ensure `CHANGELOG.md` has entry for this version with release notes
   - Push release branch

2. **Pre-release testing** on `release/*` branch:
   - CI automatically runs: CHANGELOG validation, full test suite, build
   - Pre-release APK is created for testing
   - Test thoroughly on real devices
   - Fix any issues found during testing

3. **Merge to `main`** via PR:
   - After successful testing, create PR from `release/*` to `main`
   - PR should reference release notes from CHANGELOG
   - CI must pass (release workflow runs automatically)
   - After merge: Official release build created, GitHub Release published, version tagged

4. **Backmerge to `develop`** (if needed):
   - After release, merge `release/*` changes back to `develop` if any release-specific fixes were made
   - Usually `develop` is already ahead, so this may not be necessary

### 20.3 CI/CD Integration

- **Feature/Bugfix branches**: Automatic checks on push (formatting, analyzer, tests, coverage)
- **Develop branch**: Nightly builds on merge from feature/bugfix PRs (validates CHANGELOG, builds APK, creates pre-release)
- **Release branches**: Pre-release validation and builds (full test suite, CHANGELOG validation, creates test APK)
- **Main branch**: Official release builds (validates CHANGELOG, builds release artifacts, creates GitHub Release, tags version)

### 20.4 Branch Protection Rules

- **`main`**: Protected branch, requires PR approval, CI must pass, no direct pushes
- **`develop`**: Protected branch, requires PR approval, CI must pass, no direct pushes
- **Feature/Bugfix/Release**: No protection (developers can push directly for CI checks)

GitKraken MCP and Cursor enforce branch protections and CI requirements automatically.

---

## 21. Release Management & Semantic Versioning

### 21.1 Semantic Versioning Rules

Card Snap UI follows [Semantic Versioning 2.0.0](https://semver.org/):

- **MAJOR** (`X.y.z` → `X+1.0.0`): any breaking change to public APIs, architectural contracts, comment taxonomy, or tooling that would force learners to refactor code or documentation.
- **MINOR** (`x.Y.z` → `x.Y+1.0`): new functionality delivered in a backward-compatible manner (e.g., additional features, new repositories, new educational modules).
- **PATCH** (`x.y.Z` → `x.y.Z+1`): backward-compatible bug fixes, documentation clarifications, or CI/hygiene tweaks.

Agents preparing releases must review the diff against the previous tag and propose the correct bump. When unsure, escalate to a human reviewer.

### 21.2 Release Workflow

- All releases MUST appear in GitHub Releases with attached Android (APK/AAB) and iOS (IPA) artifacts.
- Release creation is performed via a manual `workflow_dispatch` (e.g., `.github/workflows/release.yml`) that:
  1. Verifies CI status and tests.
  2. Builds distributables for both platforms.
  3. Publishes release notes sourced from `CHANGELOG.md`.
- Prior to dispatching the workflow:
  - Update `pubspec.yaml` version to the target SemVer.
  - Ensure `CHANGELOG.md` has an entry matching the new version and summarizes notable changes.
  - Confirm Conventional Commit history since the previous tag aligns with the proposed SemVer bump.

### 21.3 Changelog Policy

- Maintain a top-level `CHANGELOG.md` in [Keep a Changelog](https://keepachangelog.com/) style.
- Each release entry includes version, date, change categories (Added/Changed/Fixed/Docs), and cross-links to relevant pull requests.
- The same notes form the release description on GitHub. Ensure learners can trace changes from changelog to tagged code and release artifacts.

---

## 22. Summary

This architecture defines a **full AI-managed development environment**:

- Reactive Flutter layering and repository patterns.
- Multi-layer documentation and comment taxonomy.
- AI-assisted GitFlow, CI/CD, and observability.
- Strict Conventional Commit and branching compliance.
- A learning-first culture where every artifact tells a complete story.
- An Angular developer’s sandbox for mastering Flutter with AI mentorship, where preserving and expanding comments is the top priority.
- Semantic versioning, reproducible releases, and changelog transparency for every shipped build.

> **Goal:** Achieve continuous clarity—every commit, branch, and comment teaches the next contributor what to do and why.
