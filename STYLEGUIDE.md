# Card Snap UI — Code Style Guide

This document defines the **code style standards** for Card Snap UI Flutter project. All developers (human and AI agents) must follow these guidelines to ensure consistency, maintainability, and educational value.

> **Purpose:** This guide consolidates all code style rules, Dart/Flutter best practices, and project-specific conventions. It serves as the **single source of truth** for coding standards.
>
> **⚠️ Critical Update Rule:** When AI agents encounter new code patterns, practices, or style decisions not documented in this guide, they **MUST** update `STYLEGUIDE.md` first, then add references in code comments. See `AGENTS.md` §6.3 for complete workflow. Code comments must include references to relevant `STYLEGUIDE.md` sections using format `STYLEGUIDE.md#anchor-name (§X.Y)`.

**Related Documentation:**
- **Architecture guide:** See `ARCHITECTURE.md` for implementation patterns, clean architecture structure, and design patterns
- **AI agent playbook:** See `AGENTS.md` for how AI copilots should interpret and apply these standards (including `STYLEGUIDE.md` update requirements in §6.3)
- **Business requirements:** See `BUSINESS.md` for functional specifications and feature priorities
- **Project overview:** See `README.md` for high-level project context

---

## 1. Core Principles

### 1.1 Flutter-First Principle

**CRITICAL: CODE MUST FOLLOW FLUTTER PRACTICES ONLY**

Despite the Angular developer's background:
- ✅ **Code:** Use ONLY Flutter-idiomatic patterns (Factory, Strategy, Repository, etc.)
- ✅ **Documentation:** Use Angular analogies for explanations (`/// 🔶 Similar to Angular's...`)
- ✅ **Comments:** Translate Flutter concepts to Angular mental models (`// 🧠 Like Angular's DI...`)
- ❌ **Never:** Import Angular patterns (DI containers, tokens, registries) into Flutter code
- ❌ **Never:** Create Angular-like abstractions in code (use Flutter-native patterns instead)

**Rule:** Angular concepts exist ONLY in documentation/comments to help understanding. Code must be pure, idiomatic Flutter.

### 1.2 Effective Dart & Flutter

- Follow [Effective Dart](https://dart.dev/effective-dart) for style, documentation, usage, and API design.
- Structure Flutter apps per [Architecture Recommendations](https://docs.flutter.dev/app-architecture/recommendations), with clear data/UI separation, repository abstractions, and (as needed) domain use cases.
- Apply Factory and Strategy patterns for cross-platform adaptation.
- Create clean separation between data, domain, and presentation layers.
- Ensure all UI components use adaptive abstractions for platform-specific behavior.

### 1.3 Best Practices - Core Principles

- **YAGNI (You Aren't Gonna Need It)**: Don't add patterns, abstractions, or features until actually needed. Start simple, refactor when needed.
- **DRY (Don't Repeat Yourself)**: Extract common logic into reusable components, but only when duplication occurs more than twice.
- **KISS (Keep It Simple, Stupid)**: Prefer simple solutions over complex ones. Code should be understandable by both humans and AI agents.
- **SOLID Principles**: Follow Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion principles when architecting solutions.
- **Occam's Razor**: When multiple solutions exist, prefer the simplest one that solves the problem.
- **Avoid Premature Optimization (APO)**: Focus on correctness and readability first, optimize later when profiled performance issues exist.

---

## 2. Dart Language Syntax & Patterns

### 2.1 Syntax Comparison (Angular → Flutter / Dart)

| Concept | Angular / TypeScript | Flutter / Dart | Analogy |
|---------|----------------------|----------------|---------|
| Component | `@Component` class | `Widget` | View + logic |
| Template | HTML + bindings | Widget tree + properties | Declarative UI |
| Dependency Injection | Angular Injector | `get_it`, `provider` | Inversion of control |
| RxJS Observable | `Observable<T>` | `Stream<T>` / `Future<T>` | Async pipeline |
| Module system | `NgModule` | import + library | Grouping |
| Change Detection | Zone.js | Flutter render / `setState` | Rebuild triggers |

Use this mapping when writing comments so Angular developers can build Dart intuition quickly.

### 2.2 Dart Syntax Explained (with Angular/TypeScript Analogies)

```dart
// 🔹 `final` = assign once; similar to TS `const`, but runtime-bound flexibly.
final String name = 'Card Snap';

// 🔹 `const` = compile-time constant; useful for immutable widgets.
const Color primaryColor = Color(0xFF0078D4);

// 🔹 `late` = deferred initialization; like the TS non-null `!` assertion.
late String initializedLater;

// 🔹 `factory` = constructor returning cached/custom instances (akin to Angular providers).
factory Card.fromJson(Map<String, dynamic> json) {
  return Card(id: json['id'], name: json['name']);
}

// 🔹 `async` / `await` = Futures; similar to Promises but scheduled via Dart's event loop.
Future<List<Card>> loadCards() async {
  final data = await repository.getAllCards();
  return data;
}

// 🔹 `??` = null coalescing operator; like TS `??` or `||`.
final displayName = card.name ?? 'Unnamed Card';

// 🔹 `?.` = null-aware operator; like TS optional chaining.
final length = card.name?.length;

// 🔹 `...` = spread operator; similar to TS array/object spread.
final allCards = [...localCards, ...remoteCards];

// 🔹 `required` = named parameter that must be provided; like TS required properties.
Card({required this.id, required this.name});

// 🔹 `super.parameter` = forward to parent constructor; cleaner than manual passing.
class CustomException extends Exception {
  const CustomException(super.message, {super.technicalDetails});
}
```

### 2.3 Type Safety & Null Safety

```dart
// ✅ DO: Use nullable types when value can be null
String? nullableName;

// ✅ DO: Use non-nullable types when value is always present
String name;

// ✅ DO: Use null-aware operators
final length = nullableName?.length ?? 0;

// ❌ DON'T: Use `!` operator unnecessarily (force unwrap should be last resort)
final name = nullableName!; // Only if you're 100% sure it's not null

// ✅ DO: Use null-checking with conditional access
if (card?.isValid == true) {
  // Process card
}

// ❌ DON'T: Use `as` casts without null checks
final card = data as Card; // Unsafe - might throw

// ✅ DO: Use safe casts or validation
final card = data is Card ? data : null;
```

---

## 3. Code Quality & Linting Requirements

### 3.1 Super Parameters

**Rule:** Use `super.parameter` syntax instead of manual parameter forwarding in constructors.

```dart
// ✅ DO: Use super parameters
class DomainException implements Exception {
  const DomainException(super.message, {super.technicalDetails});
  
  // Or with named parameters
  const DomainException(super.message, {String? super.technicalDetails});
}

// ❌ DON'T: Manual parameter passing
class DomainException implements Exception {
  final String message;
  final String? technicalDetails;
  
  const DomainException(String message, {String? technicalDetails})
      : this.message = message,
        this.technicalDetails = technicalDetails;
}
```

**Why:** Reduces boilerplate, improves readability, and prevents errors when parent class changes.

### 3.2 Const Constructors

**Rule:** Add `const` keyword to constructors with compile-time constants.

```dart
// ✅ DO: Use const for compile-time constants
return const Result.success(null);
return const Result.failure(DomainException('Error message'));
final card = const Card(id: '123', name: 'Test');

// ❌ DON'T: Omit const where possible
return Result.success(null);
return Result.failure(DomainException('Error message'));
final card = Card(id: '123', name: 'Test');
```

**Why:** Enables compile-time optimization, reduces memory allocation, and improves performance.

### 3.3 Prefer Const Declarations

**Rule:** Use `const` for final variables with compile-time constant values.

```dart
// ✅ DO: Use const for compile-time constants
const defaultColor = Color(0xFF0078D4);
const defaultPadding = EdgeInsets.all(16.0);
const appName = 'Card Snap';

// ✅ DO: Use final for runtime values
final currentDate = DateTime.now();
final userCards = await repository.getAllCards();

// ❌ DON'T: Use final when const would work
final defaultColor = Color(0xFF0078D4); // Should be const
```

**Why:** Compile-time constants are evaluated once and reused, improving performance.

### 3.4 Avoid Redundant Arguments

**Rule:** Do not specify default values explicitly when they match the default.

```dart
// ✅ DO: Omit default values
ColorScheme.fromSeed(seedColor: const Color(0xFF0078D4))

// ❌ DON'T: Specify default explicitly
ColorScheme.fromSeed(
  seedColor: const Color(0xFF0078D4),
  brightness: Brightness.light, // Redundant default
)

// ✅ DO: Only specify non-default values
EdgeInsets.symmetric(horizontal: 16.0) // vertical defaults to 0
```

**Why:** Reduces noise, improves readability, and prevents confusion when defaults change.

### 3.5 Always Run Formatting & Analysis

**Rule:** Always run `dart format .` and `flutter analyze` before committing to catch issues early.

```bash
# Format all Dart files
dart format .

# Analyze for linting issues
flutter analyze
```

**Why:** These tools catch style violations, potential bugs, and performance issues before code review.

---

## 4. File Organization & Structure

### 4.1 Co-location Principle

**Rule:** Keep related files together. Strategies live with their factories in the same folder.

```
button/
  ├── button_strategy_interface.dart    # Interface
  ├── material_button_strategy.dart     # Material implementation
  ├── cupertino_button_strategy.dart    # Cupertino implementation
  ├── button_strategy_factory.dart     # Strategy factory
  └── adaptive_button_factory.dart      # Widget factory
```

**Why:** Improves discoverability, reduces navigation overhead, and makes relationships clear.

### 4.2 Meaningful File Names

**Rule:** Use meaningful file names that describe their purpose clearly.

```dart
// ✅ DO: Descriptive file names
card_repository.dart
add_card_use_case.dart
local_card_datasource.dart

// ❌ DON'T: Vague or abbreviated names
repo.dart
usecase.dart
datasource.dart
```

**Why:** Makes codebase navigation intuitive and reduces confusion.

### 4.3 Separate Files by Role

**Rule:** Each component (interface, implementation, factory) should be in its own file.

```
button/
  ├── button_strategy_interface.dart    # Strategy interface
  ├── material_button_strategy.dart     # Material implementation
  ├── cupertino_button_strategy.dart    # Cupertino implementation
  ├── button_strategy_factory.dart      # Strategy factory
  └── adaptive_button_factory.dart       # Widget factory
```

**Benefits:**
- ✅ **Single Responsibility**: Each file has one clear purpose
- ✅ **Scalability**: Easy to add new platform implementations (Windows, Linux, macOS, etc.)
- ✅ **Testability**: Can test each implementation independently
- ✅ **Maintainability**: Changes to one platform don't affect others
- ✅ **Clear Navigation**: Easy to find specific implementation
- ✅ **DRY Compliance**: Platform selection logic centralized in `StrategySelector`
- ✅ **Open/Closed Principle**: Adding new platforms doesn't require modifying existing factories

### 4.4 Shared Utilities

**Rule:** Place shared utilities in a `common/` subdirectory.

```
adaptive/
  ├── button/
  ├── card/
  ├── scaffold/
  └── common/              # Shared platform types
      ├── platform_theme.dart
      └── strategy_selector.dart
```

**Why:** Centralizes reusable code and prevents duplication.

---

## 5. Educational Comment Taxonomy

### 5.1 Comment Levels

| Level | Prefix | Purpose | Used by |
|-------|--------|---------|---------|
| **Business / Architecture** | `///` | Documents features, classes, use cases. | Humans, `dartdoc`, `mkdocs` |
| **Syntax / Framework** | `//` | Explains Dart syntax or Flutter mechanics. | Developers, AI |
| **Deep Insights** | `// 🧠` | Advanced runtime, performance, GC insights. | Developers, AI reviewers |
| **Angular Analogy** | `/// 🔶` | Connects Flutter concepts to Angular patterns. | Angular developers learning Flutter |
| **Syntax Note** | `// 🔹` | Explains Dart-specific syntax or keywords. | Developers learning Dart |

### 5.2 Documentation Expectations

- `///` describes *what* and *why* (business intent, architecture).
- `//` describes *how* (syntax, framework nuances).
- `// 🧠` offers deep dives (event loop, isolates, memory).
- `/// 🔶` provides Angular analogies for Flutter patterns.
- `// 🔹` explains Dart syntax using TypeScript comparisons.
- AI assistants must preserve all layers when generating or refactoring code.

### 5.3 Comment Examples

```dart
/// 🔶 Use Case: AddCard
/// Business operation for adding a new loyalty card.
/// Similar to Angular service methods but focused on single business operations.
/// 
/// Input: AddCardRequest with card data
/// Output: Result<LoyaltyCard> with success or failure
/// Related layers:
/// - Domain: CardRepository interface
/// - Data: LocalCardRepository implementation
/// - Presentation: AddCardForm widgets
class AddCard {
  final CardRepository repository;
  
  /// 🔹 `final` = assign once; similar to TS `const`, but runtime-bound flexibly.
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
    
    // ... rest of implementation
  }
}
```

**Critical Rule:** Comments are part of the architecture. Preserve and extend them when making changes. Never remove learning content without human approval.

---

## 6. Localization Standards

### 6.1 No Hardcoded Strings

**Rule:** No user-facing literals in UI. Always add a key to ARB (`lib/l10n/*.arb`) and use `AppLocalizations`.

```dart
// ❌ DON'T: Hardcoded strings in UI
Text('Add Card')
SnackBar(content: Text('Card saved successfully'))
AppBar(title: Text('My Cards'))

// ✅ DO: Use localization
Text(AppLocalizations.of(context).addCard)
SnackBar(content: Text(AppLocalizations.of(context).cardSavedSuccessfully))
AppBar(title: Text(AppLocalizations.of(context).myCards))
```

**Why:** Enables internationalization and maintains consistency across languages.

### 6.2 ARB File Structure

**Rule:** Use Flutter gen_l10n with ARB files stored locally (`lib/l10n/`) for offline-first translations.

**Files:**
- `l10n.yaml` — generator config
- `lib/l10n/app_en.arb`, `app_ru.arb`, `app_uk.arb`, `app_pl.arb` — MVP languages
- Output Dart: `lib/l10n/app_localizations.dart`

**Supported Languages (MVP):**
- English (`en`) — global baseline
- Russian (`ru`) — core audience
- Ukrainian (`uk`) — growing demand
- Polish (`pl`) — critical market

**Extended Languages (v1.0+):**
- German (`de`), French (`fr`), Spanish (`es`), Italian (`it`), Dutch (`nl`), Swedish (`sv`)

### 6.3 Supported Locales

**Rule:** Use `AppLocalizations.supportedLocales` rather than hardcoding `Locale` lists.

```dart
// ✅ DO: Use generated supportedLocales
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales, // Single source of truth
)

// ❌ DON'T: Hardcode locale list
MaterialApp(
  supportedLocales: [
    Locale('en'),
    Locale('ru'),
    // ... manually maintained list
  ],
)
```

**Why:** Ensures app and generator stay in sync when locales are added/removed.

### 6.4 ICU Messages (plurals, select, parameters)

**Rule:** Always prefer ICU patterns over string concatenation/interpolation in UI.

**Example (in ARB):**
```json
{
  "cardsCount": "{count, plural, =0{No cards} one{{count} card} other{{count} cards}}",
  "cardsCount@placeholders": {"count": {"type": "int"}}
}
```

**Usage in Dart:**
```dart
// ✅ DO: Use ICU messages
final label = AppLocalizations.of(context).cardsCount(count);

// ❌ DON'T: String concatenation
final label = count == 0 ? 'No cards' : '$count cards'; // Wrong!
```

**Guidelines:**
- No string concatenation for numbers/names; always add placeholders.
- Keep parameter names stable across locales; avoid formatting logic in widgets.
- Prefer domain-specific keys that are reusable across widgets (e.g., counts, errors).
- Use ICU `select` for gender/conditional messages similarly.
- When adding ICU messages, add at least one widget or unit test per branch (e.g., 0/1/other) in English.

**Why:** ICU provides proper pluralization, localization, and formatting that works across all languages.

### 6.5 Language Names

**Rule:** For language names in menus, use `LocaleNames.of(context)?.nameOf(localeTag)` (via `flutter_localized_locales`) instead of manual switches.

```dart
// ✅ DO: Use LocaleNames helper
LocaleNames.of(context)?.nameOf('ru') // Returns "Русский"

// ❌ DON'T: Manual switch statements
switch (localeTag) {
  case 'ru': return 'Русский';
  case 'en': return 'English';
  // ... error-prone manual mapping
}
```

**Why:** Automatic language name resolution based on current locale, reduces errors.

### 6.6 Locale Resolution

**Rule:** Locale resolution must use the shared helper (`LocaleController.resolveLocale`).

```dart
// ✅ DO: Use shared helper
final resolvedLocale = LocaleController.resolveLocale(deviceLocale, supported);

// ❌ DON'T: Duplicate policy in UI
final resolvedLocale = // ... custom logic scattered across widgets
```

**Why:** Centralizes locale resolution logic, ensuring consistent behavior.

### 6.7 CI Guard for Localization

**Rule:** CI pipeline must reject PRs containing UI literals.

**Example CI step:**
```bash
rg -n --glob '!**/test/**' --glob '!**/lib/l10n/**' "\b(Text|SnackBar|AppBar)\s*\(\s*(?:content:\\s*)?Text\s*\(\s*'" lib/ && exit 1 || true
```

**Why:** Enforces localization discipline automatically, catches violations before review.

---

## 7. Platform Style Guide Compliance

### 7.1 Material Design 3 (Android/Web)

**Reference:** [Material Design 3 Guidelines](https://m3.material.io/)

**Components:**
- [Cards](https://m3.material.io/components/cards)
- [Buttons](https://m3.material.io/components/buttons)

**Default Values:**
- Elevation: 1dp for cards, 3dp for elevated components
- Padding: 16dp (Material 3 spacing standard)
- Border radius: 12dp (default for cards)
- Minimum touch target: 40dp × 40dp

**Implementation Requirements:**
- All Material strategy files in `lib/presentation/widgets/adaptive/*/material_*_strategy.dart` must reference specific Material Design sections
- Comments must explain WHY values were chosen (e.g., "16dp ensures proper content breathing room per Material guidelines")
- File header MUST include link to relevant Material Design component page

**Example:**
```dart
/// 🔶 Material Card Strategy
/// Platform-specific implementation following Material Design 3 guidelines.
/// Reference: https://m3.material.io/components/cards
class MaterialCardStrategy implements CardStrategy {
  Widget createCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Card(
      elevation: 1.0, // M3 elevation level 1 for cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // M3 default border radius
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0), // M3 spacing standard
        child: child,
      ),
    );
  }
}
```

### 7.2 iOS Human Interface Guidelines (HIG)

**Reference:** [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines)

**Components:**
- [Cards](https://developer.apple.com/design/human-interface-guidelines/components/content-views/cards)
- [Buttons](https://developer.apple.com/design/human-interface-guidelines/components/selection-and-input/buttons)

**Default Values:**
- No Material elevation - use subtle shadows with 8pt blur, 2pt offset
- Border radius: 12pt (standard for cards)
- Padding: 16pt (content inset standard)
- Minimum touch target: 44pt × 44pt (accessibility requirement)
- Use `CupertinoColors.systemBackground` for automatic light/dark mode support

**Implementation Requirements:**
- All Cupertino strategy files in `lib/presentation/widgets/adaptive/*/cupertino_*_strategy.dart` must reference specific iOS HIG sections
- Comments must explain differences from Material (e.g., "iOS uses shadows instead of elevation")
- File header MUST include link to relevant iOS HIG component page

**Example:**
```dart
/// 🔶 Cupertino Card Strategy
/// Platform-specific implementation following iOS Human Interface Guidelines.
/// Reference: https://developer.apple.com/design/human-interface-guidelines/components/content-views/cards
class CupertinoCardStrategy implements CardStrategy {
  Widget createCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground, // Automatic light/dark mode
        borderRadius: BorderRadius.circular(12.0), // iOS standard border radius
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.1),
            blurRadius: 8.0, // iOS shadow blur standard
            offset: const Offset(0, 2.0), // iOS shadow offset standard
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0), // iOS HIG content inset
        child: child,
      ),
    );
  }
}
```

### 7.3 Style Guide Documentation Requirements

**Rule:** Every platform-specific strategy file MUST include:
1. Style guide reference in file header comments
2. Inline comments explaining specific values (why 16dp/16pt, why 12dp/12pt radius, etc.)
3. Educational comment taxonomy: `/// 🔶` for architecture, `// 🔹` for syntax, `// 🧠` for insights
4. Angular analogies when explaining style guide compliance

**Why:** Ensures platform-native look and feel, improves user experience, maintains design consistency, and helps Angular developers understand platform differences.

---

## 8. Architecture Patterns

### 8.1 Immutable Models

**Rule:** Favor immutable models (`freezed`, `built_value`, or hand-written) to support unidirectional data flow.

```dart
// ✅ DO: Use freezed for immutable models
@freezed
class LoyaltyCard with _$LoyaltyCard {
  const factory LoyaltyCard({
    required String id,
    required String displayName,
    String? notes,
    required String code,
    required CodeFormat codeFormat,
  }) = _LoyaltyCard;
}

// ✅ DO: Hand-written immutable classes
class LoyaltyCard {
  final String id;
  final String displayName;
  final String? notes;
  final String code;
  final CodeFormat codeFormat;

  const LoyaltyCard({
    required this.id,
    required this.displayName,
    this.notes,
    required this.code,
    required this.codeFormat,
  });

  // CopyWith for immutability
  LoyaltyCard copyWith({
    String? id,
    String? displayName,
    String? notes,
    String? code,
    CodeFormat? codeFormat,
  }) {
    return LoyaltyCard(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      notes: notes ?? this.notes,
      code: code ?? this.code,
      codeFormat: codeFormat ?? this.codeFormat,
    );
  }
}

// ❌ DON'T: Mutable models with setters
class LoyaltyCard {
  String id;
  String displayName;
  // ... mutable properties
}
```

**Why:** Immutable models prevent accidental mutations, improve testability, and support reactive state management.

### 8.2 Dependency Injection

**When to use DI (Flutter-native solutions like `get_it`, `provider`):**
- ✅ **Repositories** - `getIt<CardRepository>()` for LocalCardRepository, ApiCardRepository
- ✅ **Use Cases** - Inject dependencies via constructor: `AddCard(this.repository)`
- ✅ **Services** - EncryptionService, BackupService, LoggerService
- ✅ **Data Sources** - Network clients, database connections

**When NOT to use DI (UI/Factory patterns):**
- ❌ **UI Factories** - `AdaptiveWidgetFactory.createScaffold()` doesn't need DI (static factory methods)
- ❌ **UI Components** - Widgets get dependencies via constructor parameters
- ❌ **Strategy Classes** - Material/Cupertino strategies are simple factory selections

**Why:** DI is appropriate for business logic and services, but UI factories and widgets don't need complex DI infrastructure.

### 8.3 Error Handling Pattern

**Rule:** Use Result pattern for error handling instead of throwing exceptions.

```dart
// ✅ DO: Use Result pattern
Future<Result<LoyaltyCard>> addCard(AddCardRequest request) async {
  try {
    final card = await repository.addCard(request);
    return Result.success(card);
  } catch (e) {
    return Result.failure(DomainException('Failed to add card: $e'));
  }
}

// ❌ DON'T: Throw exceptions for expected failures
Future<LoyaltyCard> addCard(AddCardRequest request) async {
  if (!request.isValid) {
    throw DomainException('Invalid request'); // Forces try-catch everywhere
  }
  return await repository.addCard(request);
}
```

**Why:** Result pattern makes error handling explicit, improves type safety, and prevents uncaught exceptions.

---

## 9. Testing Standards

### 9.1 Test Coverage Requirements

| Layer | Minimum Coverage | Rationale |
|-------|------------------|-----------|
| **Domain** | 90%+ | Business logic must be bulletproof—this is the core of the application. Pure Dart code with no external dependencies makes it highly testable. |
| **Data** | 80%+ | Data operations are critical for offline-first architecture. Repository implementations must be thoroughly validated. |
| **Presentation** | 70%+ | UI behavior and state management require validation. Widget tests ensure proper rendering and user interactions. |
| **Core** | 85%+ | Cross-cutting concerns (platform detection, error handling, constants) must be reliable. |

### 9.2 Test File Organization

```
test/
 ├── unit/                   # Unit tests for domain logic
 ├── widget/                 # Widget tests
 ├── integration/            # Integration tests
 └── mocks/                  # Mock implementations
```

**Rule:** Co-locate test files with source files when possible, or organize by layer.

---

## 10. Code Review Checklist

Before submitting code for review, verify:

- ✅ Code follows Flutter best practices (not Angular patterns)
- ✅ Uses proper state management (BLoC, Riverpod, etc.)
- ✅ Implements Clean Architecture (domain/data/presentation separation)
- ✅ Cross-platform compatibility (Material + Cupertino strategies)
- ✅ Proper error handling with Result pattern
- ✅ Dependency injection (get_it or provider) for business logic
- ✅ Tests written and passing
- ✅ Documentation includes educational comments
- ✅ No platform-specific hardcoding
- ✅ Follows SOLID principles
- ✅ All user-facing strings use `AppLocalizations`
- ✅ Code formatted with `dart format .`
- ✅ No linting errors (`flutter analyze`)
- ✅ Test coverage thresholds met

---

## 11. Quick Reference Commands

```bash
# Format code
dart format .

# Analyze for linting issues
flutter analyze

# Run tests
flutter test

# Run tests with coverage
flutter test --coverage

# Generate localization files
flutter gen-l10n
```

---

## 12. References

- [Effective Dart](https://dart.dev/effective-dart) - Official Dart style guide
- [Flutter Architecture Recommendations](https://docs.flutter.dev/app-architecture/recommendations) - Official Flutter architecture guide
- [Material Design 3](https://m3.material.io/) - Android/Web design guidelines
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines) - iOS design guidelines
- [Conventional Commits](https://www.conventionalcommits.org/) - Commit message format

---

This style guide is a living document. Update it when new patterns or standards are established. All contributors (human and AI) must follow these guidelines.

**⚠️ Update Workflow**: When encountering new patterns not documented here, AI agents MUST follow the complete workflow in `AGENTS.md` §6.3 (update `STYLEGUIDE.md` first, then add references in code).
