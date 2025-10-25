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

---

## 3. Core Architectural Goals

- Ship a maintainable Android + iOS Flutter application.
- Keep design clean, reactive, testable, and loosely coupled.
- Automate CI/CD from linting to store-ready builds.
- Provide structured logging and observability from day one.
- Maintain flexibility for experiments without disrupting learning flow.
- Prefer **loose coupling over tight coupling**, especially in domain use cases; depend on abstractions to keep the architecture adaptable.

---

## 4. Syntax Comparison (Angular → Flutter / Dart)

| Concept | Angular / TypeScript | Flutter / Dart | Analogy |
|---------|----------------------|----------------|---------|
| Component | `@Component` class | `Widget` | View + logic |
| Template | HTML + bindings | Widget tree + properties | Declarative UI |
| Dependency Injection | Angular Injector | `get_it`, `provider` | Inversion of control |
| RxJS Observable | `Observable<T>` | `Stream<T>` / `Future<T>` | Async pipeline |
| Module system | `NgModule` | import + library | Grouping |
| Change Detection | Zone.js | Flutter render / `setState` | Rebuild triggers |

Use this mapping when writing comments so Angular developers can build Dart intuition quickly.

---

## 5. Architecture & Design Patterns

### 5.1 Adaptive Widget Factory

The application uses adaptive widget factory for cross-platform UI adaptation, similar to Angular's platform detection service.

```dart
/// 🔶 Adaptive Widget Factory: Platform-Specific UI Adaptation
/// Similar to Angular's platform detection service that adapts components
/// based on browser/device capabilities and user preferences.
class AdaptiveWidgetFactory {
  static PlatformTheme getCurrentTheme() {
    try {
      if (Platform.isIOS) return PlatformTheme.cupertino;
      if (Platform.isAndroid) return PlatformTheme.material;
    } catch (e) {
      // Web platform fallback
      return PlatformTheme.material;
    }
    return PlatformTheme.material;
  }
  
  static Widget createCardTile({
    required LoyaltyCard card,
    required VoidCallback onTap,
  }) {
    final theme = getCurrentTheme();
    switch (theme) {
      case PlatformTheme.cupertino:
        return CupertinoCardTile(card: card, onTap: onTap);
      case PlatformTheme.material:
      default:
        return MaterialCardTile(card: card, onTap: onTap);
    }
  }
}
```

### 5.2 Key Design Patterns Applied

**Factory Pattern** - `AdaptiveWidgetFactory` creates platform-specific UI components based on runtime detection. Each widget type (scaffold, card, button) has its own factory for modularity.

**Strategy Pattern** - Platform-specific implementations are encapsulated in strategy classes. Each widget has its own strategy file (`button_strategy.dart`, `card_strategy.dart`, etc.) living alongside its factory in the same folder. This follows co-location principle and improves maintainability.

**Repository Pattern** - Abstracts data access layer with `CardRepository` interface and implementations. Similar to Angular's service layer that abstracts HTTP calls.

**Use Cases Pattern** - Encapsulates business logic in dedicated use case classes. Similar to Angular's service methods that coordinate between services and components.

**Dependency Injection** - Domain layer depends on abstractions (repository interfaces) rather than concrete implementations, ensuring loose coupling.

**Best Practices Applied**

- **YAGNI (You Aren't Gonna Need It)**: Only add patterns when actually needed, start simple.
- **DRY (Don't Repeat Yourself)**: Extract common logic, but only when duplication occurs more than twice.
- **KISS (Keep It Simple, Stupid)**: Prefer simple solutions that both humans and AI can understand.
- **SOLID Principles**: Apply Single Responsibility, Open/Closed, and Dependency Inversion in architecture decisions.
- **Occam's Razor**: When multiple solutions exist, choose the simplest one.
- **Avoid Premature Optimization**: Focus on correctness first, optimize when profiling shows issues.

**File Organization**
- **Co-location**: Keep related files together. Strategies live with their factories in the same folder.
- **Meaningful Names**: File names should describe their purpose clearly.
- **Shared Utilities**: Place common code in `common/` subdirectory.

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

## 6. Key Technologies

| Category | Tools / Packages | Notes |
|----------|------------------|-------|
| State Management | `flutter_bloc` or `riverpod` | Reactive store similar to NgRx. |
| Dependency Injection | `get_it` (with `injectable` optional) | Declarative service locator. |
| Networking | `dio` (+ `retrofit`) | HTTP client with interceptors and typed clients. |
| Logging | `logger` + OTLP sink | JSON logs routed to OpenTelemetry. |
| Testing | `flutter_test`, `mocktail`, `integration_test` | Core + UI + E2E coverage. |
| Observability | OTel Collector + OpenSearch | Unified traces and dashboards. |
| CI/CD | GitHub Actions | Lint → Test → Coverage → Build. |

### 6.1 pubspec.yaml Baseline

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
```

- Add `analysis_options.yaml` referencing the chosen lint package (e.g., `include: package:very_good_analysis/analysis_options.yaml`).
- Configure code generation scripts in `tool/` as needed (`dart run build_runner build --delete-conflicting-outputs`).
- Update versions as newer stable releases become available; document rationale in `CHANGELOG.md`.

---

## 7. Cross-Platform Support Strategy

Card Snap UI must deliver identical learning and runtime value on **Android** and **iOS**. Every feature, test, and observability hook is evaluated for cross-platform parity.

| Topic | Policy | Rationale |
|-------|--------|-----------|
| **Target Platforms** | Android (API 23+), iOS (iOS 14+). | Covers modern devices while remaining installable on older hardware. |
| **Platform Neutral Code** | Business logic, repositories, and widgets default to platform-agnostic Flutter APIs. | Keeps the educational domain layer truly cross-platform. |
| **Platform Conditionals** | Encapsulate platform-specific branches inside dedicated adapters (e.g., `core/platform/`). Document with `// 🧠` comments that explain why the divergence exists. | Avoids scattering `Platform.is...` checks and preserves learnability. |
| **Device Testing** | Run widget tests for both platform themes (Material + Cupertino) when UI diverges. Run integration tests on Android emulator + iOS simulator before release. | Ensures consistent UX and surfaces platform quirks early. |
| **Build & Release** | CI/CD provides artifacts for both platforms; fastlane (or equivalent) scripts belong in `infra/`. | Reinforces the production-ready objective and keeps release steps reproducible. |
| **Dependencies** | Avoid platform-only packages unless there is no Flutter-first alternative; when required, wrap them behind abstractions and document trade-offs. | Maintains educational focus on shared architecture patterns. |

> When introducing new features, include a note in the PR/commit describing cross-platform considerations (UI, permissions, native integrations) and reference relevant tests or platform adapters.

---

## 8. Domain Layer Principles & Documentation

- Domain layer stays **pure Dart** (no Flutter imports).
- Depends solely on **abstract repositories** and **strategy interfaces** (Dependency Inversion).
- Favor **loose coupling**: inject interfaces into use cases, keep constructors lightweight, and avoid depending on framework-specific classes.
- Use **Strategy pattern** for business logic: different implementations can be swapped based on requirements (Local, API, Hybrid).
- Implement **Command pattern** for user actions: commands are executable, undoable, and easily testable.
- Design each use case with **flexibility in mind**, allowing multiple repository implementations (API, LocalDB, Hybrid) to be swapped without rewriting business logic.
- Each use case is **unit-testable**, thoroughly commented, and explains how it maps back to Angular patterns.
- Documentation within the file states purpose, inputs, outputs, and collaborating layers.

```dart
/// 🔶 Use Case: RegisterDevice (Strategy Pattern Implementation)
/// Defines how a device is registered to user account using different strategies.
/// Input: Device info, auth token, strategy type
/// Output: Device model with backend-assigned ID.
/// Related layers:
/// - Domain: DeviceRegistrationStrategy interface
/// - Data: DeviceRepository implementations
/// - Presentation: DeviceRegistrationForm
class RegisterDevice {
  final DeviceRegistrationStrategy strategy;
  
  RegisterDevice(this.strategy);

  /// Executes the use case by delegating to the selected strategy.
  /// 🧠 Pure domain logic: no networking or UI references.
  /// 🧠 Strategy pattern allows different implementations (Local, API, Hybrid).
  Future<Device> execute(DeviceRegistration payload) async =>
      strategy.register(payload);
}

/// 🔶 Command Pattern: Device Registration Command
/// Encapsulates device registration as an executable command.
/// Similar to Angular's command pattern for user interactions.
class RegisterDeviceCommand implements Command {
  final RegisterDevice useCase;
  final DeviceRegistration payload;
  
  RegisterDeviceCommand(this.useCase, this.payload);
  
  @override
  Future<void> execute() async {
    await useCase.execute(payload);
  }
  
  @override
  Future<void> undo() async {
    // Implementation for undo (e.g., unregister device)
  }
  
  @override
  String get description => 'Register device: ${payload.deviceName}';
}
```

Feature narratives (e.g., device management) should outline end-to-end flows and highlight caching/offline strategies.

---

## 9. Repository Patterns & Strategy Implementation

**Goal:** Teach how different data sources interact through the same interface using Strategy pattern.

| Pattern | Description | Lesson |
|---------|-------------|--------|
| API Strategy | Remote data via Dio/HTTP | Separate domain decisions from I/O details. |
| Local Strategy | Hive/SQLite persistence | Offline-first and caching patterns. |
| Hybrid Strategy | API + Local cache | Resilience and graceful degradation. |

```dart
/// 🔷 Strategy Pattern Implementation teaches resilience and fallback patterns.
/// Similar to Angular's service strategies that can be injected based on configuration.
abstract class CardManagementStrategy {
  Future<Result<List<LoyaltyCard>>> getAllCards();
  Future<Result<LoyaltyCard>> addCard(CardData data);
  Future<Result<void>> deleteCard(String cardId);
}

class LocalCardStrategy implements CardManagementStrategy {
  final LocalCardRepository repository;
  LocalCardStrategy(this.repository);
  
  @override
  Future<Result<List<LoyaltyCard>>> getAllCards() async {
    // 🧠 Local-only implementation: fast, offline-capable
    return repository.getAllCards();
  }
}

class HybridCardStrategy implements CardManagementStrategy {
  final ApiCardRepository api;
  final LocalCardRepository cache;
  
  HybridCardStrategy(this.api, this.cache);
  
  @override
  Future<Result<List<LoyaltyCard>>> getAllCards() async {
    try {
      final remote = await api.getAllCards();
      for (final card in remote.dataOrNull!) {
        await cache.saveCard(card);
      }
      return remote;
    } catch (_) {
      // 🧠 Offline fallback: highlight resilience and UX.
      return cache.getAllCards();
    }
  }
}
```

Document why a pattern is chosen and how it improves the learner’s understanding.

---

## 10. Testing Strategy

| Type | Purpose | Tools | Required |
|------|---------|-------|----------|
| **Unit** | Validate domain logic and pure services. | `flutter_test`, `mocktail` | ✅ |
| **Widget/UI** | Verify rendering and widget state behavior. | `flutter_test` | ✅ |
| **E2E / Integration** | Simulate user journeys with mocked backend. | `integration_test`, `http_mock_adapter` | ✅ |
| **Optional** | Golden or snapshot verification. | `golden_toolkit` | ➖ |

> Production-grade coverage = Unit + Widget + E2E. Each test includes educational assertions and comments that explain what is being verified and why.

---

## 11. CI/CD & AI Automation

- GitHub Actions enforce linting, formatting, testing, and coverage.
- Cursor and GitKraken MCP manage GitFlow branches and Conventional Commits.
- AI agents annotate CI steps with educational commentary (why the step exists).

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

## 12. Observability & Trace Learning

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

## 13. Educational Comment & Documentation Policy

### Comment Taxonomy

| Level | Prefix | Purpose | Used by |
|-------|--------|---------|---------|
| **Business / Architecture** | `///` | Documents features, classes, use cases. | Humans, `dartdoc`, `mkdocs` |
| **Syntax / Framework** | `//` | Explains Dart syntax or Flutter mechanics. | Developers, AI |
| **Deep Insights** | `// 🧠` | Advanced runtime, performance, GC insights. | Developers, AI reviewers |

### Documentation Expectations

- `///` describes *what* and *why* (business intent, architecture).
- `//` describes *how* (syntax, framework nuances).
- `// 🧠` offers deep dives (event loop, isolates, memory).
- AI assistants must preserve all three layers when generating or refactoring code.

### Using Documentation for AI Context

1. Comments serve as the curriculum—do not remove them.
2. DartDoc output feeds AI context for future tasks.
3. Annotate commits/pull requests with links to relevant comments or docs.

> Treat comments as immutable contracts unless the learning content changes.

---

## 14. Syntax Explanation Policy

Explain Dart syntax using TypeScript analogies so cross-ecosystem developers learn faster:

```dart
// 🔹 `final` = assign once; similar to TS `const`, but runtime-bound flexibly.
// 🔹 `const` = compile-time constant; useful for immutable widgets.
// 🔹 `late` = deferred initialization; like the TS non-null `!` assertion.
// 🔹 `factory` = constructor returning cached/custom instances (akin to Angular providers).
// 🔹 `async` / `await` = Futures; similar to Promises but scheduled via Dart's event loop.
```

Reference how each keyword impacts rebuilds, isolates, or state management.

---

## 15. Documentation Integration Workflow

**DartDoc**

```bash
dart doc
```

Generates static HTML in `/doc/api/`, surfacing `///` comments.

**MkDocs**

```bash
pip install mkdocs mkdocs-material
mkdocs serve
```

Example `mkdocs.yml`:

```yaml
site_name: Card Snap UI Documentation
docs_dir: docs
nav:
  - Overview: index.md
  - Architecture: architecture_overview.md
  - Features:
      - Authentication: features/auth.md
      - Devices: features/devices.md
  - Domain: domain/overview.md
theme:
  name: material
  features:
    - navigation.expand
    - search.highlight
```

> Documentation updates are part of every feature or bugfix. Regenerate artifacts when comments or guides change.

---

## 16. AI Collaboration Workflow

- Follow the playbook in `AGENTS.md` for Observe → Plan → Execute → Review.
- Humans use `README.md` as the entry point; AI must reconcile changes with sections in this file.
- When choices exist, surface trade-offs and seek human confirmation before deviating from architecture.

---

## 17. Repository & Version Control Policy

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

## 18. Conventional Commits Standard

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

## 19. Branching Strategy

The repository follows **GitFlow**, adapted for AI-managed workflows.

| Branch | Purpose |
|--------|---------|
| `main` | Stable production releases only. |
| `develop` | Active development (feature merges). |
| `feature/*` | One feature or task per branch. |
| `release/*` | Pre-release stabilization. |
| `hotfix/*` | Urgent fixes against production. |

### Example Workflow

1. Create `feature/auth-login`.
2. Develop & test → commit via Cursor using Conventional Commits.
3. Open PR into `develop`; CI must pass and reviewers approve.
4. Create `release/1.0.0` for stabilization.
5. Merge to `main`, tag `v1.0.0`, and deploy.

GitKraken MCP and Cursor enforce branch protections and CI requirements automatically.

---

## 20. Release Management & Semantic Versioning

### 20.1 Semantic Versioning Rules

Card Snap UI follows [Semantic Versioning 2.0.0](https://semver.org/):

- **MAJOR** (`X.y.z` → `X+1.0.0`): any breaking change to public APIs, architectural contracts, comment taxonomy, or tooling that would force learners to refactor code or documentation.
- **MINOR** (`x.Y.z` → `x.Y+1.0`): new functionality delivered in a backward-compatible manner (e.g., additional features, new repositories, new educational modules).
- **PATCH** (`x.y.Z` → `x.y.Z+1`): backward-compatible bug fixes, documentation clarifications, or CI/hygiene tweaks.

Agents preparing releases must review the diff against the previous tag and propose the correct bump. When unsure, escalate to a human reviewer.

### 20.2 Release Workflow

- All releases MUST appear in GitHub Releases with attached Android (APK/AAB) and iOS (IPA) artifacts.
- Release creation is performed via a manual `workflow_dispatch` (e.g., `.github/workflows/release.yml`) that:
  1. Verifies CI status and tests.
  2. Builds distributables for both platforms.
  3. Publishes release notes sourced from `CHANGELOG.md`.
- Prior to dispatching the workflow:
  - Update `pubspec.yaml` version to the target SemVer.
  - Ensure `CHANGELOG.md` has an entry matching the new version and summarizes notable changes.
  - Confirm Conventional Commit history since the previous tag aligns with the proposed SemVer bump.

### 20.3 Changelog Policy

- Maintain a top-level `CHANGELOG.md` in [Keep a Changelog](https://keepachangelog.com/) style.
- Each release entry includes version, date, change categories (Added/Changed/Fixed/Docs), and cross-links to relevant pull requests.
- The same notes form the release description on GitHub. Ensure learners can trace changes from changelog to tagged code and release artifacts.

---

## 21. Summary

This architecture defines a **full AI-managed development environment**:

- Reactive Flutter layering and repository patterns.
- Multi-layer documentation and comment taxonomy.
- AI-assisted GitFlow, CI/CD, and observability.
- Strict Conventional Commit and branching compliance.
- A learning-first culture where every artifact tells a complete story.
- An Angular developer’s sandbox for mastering Flutter with AI mentorship, where preserving and expanding comments is the top priority.
- Semantic versioning, reproducible releases, and changelog transparency for every shipped build.

> **Goal:** Achieve continuous clarity—every commit, branch, and comment teaches the next contributor what to do and why.
