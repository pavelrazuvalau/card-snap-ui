# Card Snap UI — AI-Assisted Flutter Learning Playground

**Card Snap UI** is a Flutter codebase for developing **Card Snap Wallet** — an offline-first loyalty and discount card manager for Android and iOS.  
The repository is engineered as a self-guided tutorial where every module, test, and workflow teaches an Angular/TypeScript developer how a production-grade Flutter app is assembled, with AI copilots acting as patient mentors instead of raw automation.

> Guiding idea: **write so AI can teach it, and humans can learn it.**

---

## Why This Repo Exists

This repository serves two primary purposes:

1. **Build Card Snap Wallet** — A production-ready, offline-first mobile application for managing loyalty and discount cards. All features must satisfy business requirements defined in `BUSINESS.md`.
2. **Educational Platform** — A comprehensive learning resource that:
   - translates familiar Angular patterns into idiomatic Dart/Flutter
   - documents *why* architectural choices exist, not just *what* the code does
   - pairs human curiosity with AI explanations so the project functions like a textbook
   - ensures business requirements guide all architectural decisions

Depth of understanding comes before delivery speed. Clarity, commentary, and reproducibility are the default success metrics. **All implementations must align with business requirements in `BUSINESS.md`.**

---

## Where to Go Next

- **🔴 CRITICAL: Business requirements & SRS baseline:** [BUSINESS.md](BUSINESS.md) - **Primary source of truth** for all business rules, functional requirements, user stories, and feature priorities
- **Architecture & detailed patterns:** [ARCHITECTURE.md](ARCHITECTURE.md) - Must align with `BUSINESS.md` requirements
- **Code style standards & best practices:** [STYLEGUIDE.md](STYLEGUIDE.md) - **Single source of truth** for Dart/Flutter coding standards, syntax explanations, and style guide compliance
- **AI copilot operating rules:** [AGENTS.md](AGENTS.md) - Agents must follow `BUSINESS.md` by default and `STYLEGUIDE.md` for code style
- **Automation & infrastructure:** [infra/](infra/)
- **Narrative docs & guides:** [docs/](docs/)
- **Release process & changelog:** [ARCHITECTURE.md](ARCHITECTURE.md) §20, [CHANGELOG.md](CHANGELOG.md)

## Project Structure & Key Files

### Documentation
- [ARCHITECTURE.md](ARCHITECTURE.md) - Detailed architecture guide
- [BUSINESS.md](BUSINESS.md) - Business requirements
- [STYLEGUIDE.md](STYLEGUIDE.md) - Code style standards and Dart/Flutter best practices
- [AGENTS.md](AGENTS.md) - AI copilot playbook
- [MOBILE_SETUP.md](MOBILE_SETUP.md) - Mobile development setup guide

### Launch Scripts
- [run_web.sh](run_web.sh) - Linux/macOS web launcher
  - Chrome (hot reload) - Recommended
  - Edge (hot reload)
  - Firefox (static build)
  - Run tests
- [run_web.bat](run_web.bat) - Windows CMD launcher
  - Chrome (hot reload) - Recommended
  - Edge (hot reload)
  - Firefox (static build)
  - Run tests
- [run_app.ps1](run_app.ps1) - PowerShell launcher
  - Chrome (hot reload) - Recommended
  - Edge (hot reload)
  - Firefox (static build)
  - Run tests
  - Check Flutter setup

### Core Platform Layer
- [lib/core/platform/browser_launcher.dart](lib/core/platform/browser_launcher.dart) - Browser abstraction interface
- [lib/core/platform/README.md](lib/core/platform/README.md) - Platform layer documentation
- [lib/core/platform/CHANGELOG.md](lib/core/platform/CHANGELOG.md) - Platform layer version history

### Source Code Layers
- [lib/core/](lib/core/) - Core utilities and constants
  - [lib/core/constants/app_constants.dart](lib/core/constants/app_constants.dart) - App-wide constants
  - [lib/core/errors/app_exceptions.dart](lib/core/errors/app_exceptions.dart) - Error handling
  - [lib/core/platform/](lib/core/platform/) - Platform-specific adaptations
- [lib/domain/](lib/domain/) - Pure business logic (no Flutter imports)
  - [lib/domain/entities/card.dart](lib/domain/entities/card.dart) - Card entity
  - [lib/domain/repositories/card_repository.dart](lib/domain/repositories/card_repository.dart) - Repository interface
  - [lib/domain/usecases/add_card.dart](lib/domain/usecases/add_card.dart) - Add card use case
- [lib/data/](lib/data/) - Data sources and repositories
  - [lib/data/repositories/local_card_repository.dart](lib/data/repositories/local_card_repository.dart) - Local implementation
  - [lib/data/datasources/local_card_datasource.dart](lib/data/datasources/local_card_datasource.dart) - Data source
- [lib/presentation/](lib/presentation/) - UI layer
  - [lib/presentation/pages/card_list_page.dart](lib/presentation/pages/card_list_page.dart) - Card list page
  - [lib/presentation/widgets/](lib/presentation/widgets/) - Reusable widgets
    - [lib/presentation/widgets/adaptive/](lib/presentation/widgets/adaptive/) - Adaptive cross-platform widgets
      - Factory pattern for platform-specific UI components
      - Supports Material, Cupertino, and Web themes
- [lib/main.dart](lib/main.dart) - Application entry point

---

## Quick Start

### Web Development (Local Testing)
```bash
# Windows (CMD)
run_web.bat

# Windows (PowerShell)
.\run_app.ps1

# Linux/Mac  
./run_web.sh

# Manual - choose your browser
flutter run -d chrome     # Chrome (recommended)
flutter run -d edge       # Edge
flutter build web         # Build for Firefox, then open in browser
```

### Mobile Development (iOS/Android)
```bash
# Check setup
flutter doctor

# Run on connected device
flutter run -d <device-id>

# Build for production
flutter build apk --release    # Android
flutter build ios --release    # iOS
```

### Prerequisites
- **Flutter SDK** 3.9.2+
- **Android Studio** (for Android development)
- **Xcode** (for iOS development, macOS only)
- **Web Browsers** (for web development):
  - Chrome (recommended, hot reload support)
  - Edge (hot reload support)
  - Firefox (requires build step, no hot reload)

> **Note:** Flutter's web support currently provides hot reload for Chrome and Edge only. For Firefox, use `flutter build web` then open `build/web/index.html` in the browser.

### Verification & Testing

Before committing changes, verify the project:

```bash
# 1. Run linter (must pass with no errors or warnings)
flutter analyze

# 2. Run tests (all tests must pass)
flutter test

# 3. Run tests with coverage
flutter test --coverage

# 4. Format code
dart format .

# 5. Verify build (optional but recommended)
flutter build web
```

See `test/README.md` for detailed testing strategy and coverage requirements. Use `flutter test integration_test` for end-to-end suites when changes cross layers. See `ARCHITECTURE.md` for architecture-specific testing guidance.

### Code Quality Standards

AI agents must follow code quality requirements defined in `STYLEGUIDE.md`. **See `STYLEGUIDE.md` §3** for comprehensive code quality and linting requirements.

**Quick Reference:**
- Use `super.parameter` syntax for cleaner constructors
- Add `const` keyword for compile-time constants
- Avoid redundant default arguments
- Run `dart format .` and `flutter analyze` before committing
- Include `STYLEGUIDE.md` references in code comments (see `AGENTS.md` §6.3)

**Code Comments & Documentation:**
See `AGENTS.md` §6.3 for complete guidelines on adding `STYLEGUIDE.md` references in code comments, format specifications, and discovery workflow when encountering new patterns.

See `STYLEGUIDE.md` §3 for comprehensive guidelines and examples. See `AGENTS.md` §6.3 for comment and reference requirements.

---

## Run on Specific Platforms

- **Android:**  
  1. Ensure an emulator or device is connected (`flutter devices`).  
  2. Run `flutter run -d <deviceId>` for debug builds.  
  3. For release builds, use `flutter build apk` or `flutter build appbundle` followed by the release workflow in `infra/`.

- **iOS (macOS required):**  
  1. Open Xcode once and accept licenses (`sudo xcodebuild -runFirstLaunch`).  
  2. Run `flutter run -d <iOS simulator/device>` for development; use `flutter build ipa` inside the release workflow for distribution.  
  3. Provisioning profiles and signing configs live in `infra/` to keep the process reproducible.

- **Web/Desktop (optional experiments):**  
  Enable the desired platform with `flutter config --enable-<platform>-desktop` or `--enable-web`, then run `flutter run -d chrome` or the relevant desktop device. Treat these builds as educational sandboxes unless explicitly promoted to release scope.

> The current environment may not have Flutter installed. Do not execute these commands until the toolchain is available; keep the instructions for future reference.

---

## Key Architectural Patterns

Card Snap UI follows clean architecture principles with clear separation of concerns:

- **Factory Pattern**: `AdaptiveWidgetFactory` creates platform-specific UI components (Material/Cupertino/Web) based on runtime detection
- **Repository Pattern**: Abstracts data access with `CardRepository` interface and concrete implementations
- **Use Cases Pattern**: Encapsulates business logic in dedicated use case classes
- **Dependency Injection**: Domain layer depends on abstractions (interfaces) rather than concrete implementations

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed pattern documentation.

---

## Educational Comment Philosophy

| Type | Prefix | Purpose |
|------|--------|---------|
| Documentation | `///` | Architectural intent captured by `dartdoc`/mkdocs. |
| Syntax Explanation | `//` | Dart language clarifications for developers who think in Angular. |
| Deep Insights | `// 🧠` | Runtime, async, and memory insights that invite deeper exploration. |

Comments are part of the architecture. Preserve and extend them when making changes.

---

## Collaborating with AI

Cursor, GitKraken MCP, and other copilots must follow the playbook in `AGENTS.md`. The playbook defines identity, guardrails, workflow, and communication style so every automated change remains faithful to the project's teaching mission and business requirements.

**AI agents must:**
- Follow business requirements in `BUSINESS.md` by default
- Align architectural decisions with `ARCHITECTURE.md` patterns
- Follow code style standards in `STYLEGUIDE.md` for all code changes
- Add `STYLEGUIDE.md` references in code comments and update documentation per `AGENTS.md` §6.3
- Reference functional specifications and acceptance criteria from `BUSINESS.md` during implementation
- Ensure all features satisfy MUST/SHOULD/WON'T priorities defined in `BUSINESS.md` §2
