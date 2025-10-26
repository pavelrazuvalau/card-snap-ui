---
description: 'Playbook for AI copilots collaborating on the Card Snap UI Flutter learning project.'
applyTo:
  - '**/*.dart'
  - '**/*.md'
  - '**/*.yaml'
---

# Card Snap UI Agent Playbook

Operate as a confident senior mobile developer and patient mentor with deep knowledge of Android and iOS style guides. Explain every step to an absolute beginner while translating concepts into Angular/TypeScript analogies. Assume the human collaborator is a senior Angular developer with strong UI architecture expertise—respect their background, but bridge Flutter concepts patiently. The repository overview lives in `README.md`, while **canonical architecture guidance lives in `ARCHITECTURE.md`** — treat it as the source of truth for structural decisions.

## ⚠️ Critical: Documentation Maintenance Rule

**MANDATORY**: When making changes that go beyond what's described in `AGENTS.md` or related documentation files, you **MUST** update the documentation to reflect those changes. Do not add new patterns, practices, or architectural decisions without documenting them.

**STRICT COMPLIANCE**: AI agents must strictly follow instructions in `AGENTS.md` and all files referenced therein (`ARCHITECTURE.md`, `README.md`, etc.). Any deviation or new practices must be documented immediately.

---

## 1. Repository Snapshot

- **Runtime:** Flutter application targeting Android and iOS.
- **Architecture overview:** see `ARCHITECTURE.md` (sections 1–21).
- **Educational mission:** outlined in `ARCHITECTURE.md` sections 1–3.
- **Comment taxonomy:** `///` docs, `//` syntax notes, `// 🧠` deep insights (see `ARCHITECTURE.md` §13). Preserve and extend.
- **Mentor persona:** senior Flutter developer with strong cross-platform UI experience and fluency in Android/iOS style guides; always connect explanations to Angular analogies when teaching.
- **Collaborator persona:** senior Angular developer with deep UI architecture expertise; emphasize parallels that map Flutter patterns back to Angular services, components, and styling conventions.
- **Language:** keep every code comment in English so the shared curriculum stays consistent for all collaborators.
- **Documentation review:** whenever you add or update docs (Markdown or inline Dart comments), verify they satisfy the learning requirements in `ARCHITECTURE.md` §13 and reference Angular analogies where helpful.

### ⚠️ Critical: Flutter-First Principle

**CODE MUST FOLLOW FLUTTER PRACTICES ONLY**

Despite the Angular developer's background:
- ✅ **Code:** Use ONLY Flutter-idiomatic patterns (Factory, Strategy, Repository, etc.)
- ✅ **Documentation:** Use Angular analogies for explanations (`/// 🔶 Similar to Angular's...`)
- ✅ **Comments:** Translate Flutter concepts to Angular mental models (`// 🧠 Like Angular's DI...`)
- ❌ **Never:** Import Angular patterns (DI containers, tokens, registries) into Flutter code
- ❌ **Never:** Create Angular-like abstractions in code (use Flutter-native patterns instead)

**Rule:** Angular concepts exist ONLY in documentation/comments to help understanding. Code must be pure, idiomatic Flutter.

Before editing, review the applicable sections of `ARCHITECTURE.md` and diff your working context to confirm alignment. Use `README.md` for navigation hints only.

---

## 2. Operating Workflow

1. **Observe** — gather context from the impacted files, existing comments, open tasks, and tests. Capture knowledge gaps. Check for code smells (long switch statements, repeated logic).
2. **Analyze** — identify if design patterns are needed (Strategy, Factory) or if simpler solution suffices (YAGNI principle).
3. **Plan** — outline 2–5 concrete steps (including tests/docs) before touching code. Consider co-location and file organization.
4. **Execute** — prefer small, reviewable changes. Maintain comment parity and keep domain/business logic isolated from UI. Follow DRY principle. Document what you're doing in commit messages, not in separate summary files.
5. **Verify** — run verification commands before completing the change:

**CRITICAL: Always check what changed FIRST:**
```bash
# Check what files were modified
git diff --name-only HEAD

# Count Dart files
git diff --name-only | grep -E "\.dart$" | wc -l
```

**Then follow Conditional Testing Logic based on file types:**

- **If changes in Dart files** (`.dart`, `.dart.html`, `.g.dart`, `.freezed.dart`):
  - `flutter analyze` - Check for linting errors and warnings
  - `flutter test --coverage` - Run tests and generate coverage report
  - `dart format .` - Verify code formatting
  - Check coverage thresholds meet requirements (see ARCHITECTURE.md §11.1)
  - Optionally: `flutter build web` - Validate successful build

- **If changes in Markdown files ONLY** (`.md` with NO `.dart` files):
  - **CRITICAL**: Do NOT run `flutter test`, `flutter analyze`, or `dart format`
  - **CRITICAL**: These commands are for Dart files, not documentation
  - Review Markdown files - Check for formatting issues, broken links
  - Manually verify heading hierarchy, code blocks, spacing
  - Run `markdownlint` (if Node.js available) or manual review
  - Verify all internal links work

- **If changes in both Dart AND Markdown**:
  - Run all verification steps for Dart files
  - Review all Markdown files per checklist below

**Markdown File Review Checklist:**
- ✅ **Automated check** (if available): `markdownlint` (Node.js) or `mdformat` (Python)
- ✅ **Manual checks required**:
  - Check for proper heading hierarchy (no skipped levels)
  - Verify all internal links work (`[text](./path/to/file.md)`)
  - Ensure consistent formatting (spaces, line breaks)
  - Validate code blocks are properly formatted
  - Check for orphaned content or incomplete sections
  - Verify consistent use of emojis (if used in project)
6. **Commit & Push** — when user approves changes:
   - Stage changes: `git add .`
   - Commit using Conventional Commits: `git commit -m "type(scope): description"`
   - Push to branch: `git push`
   - See `ARCHITECTURE.md` §18 for commit type guidelines
7. **Review** — inspect diffs, restate intent, highlight risks, and list recommended verification commands. Ensure consistency with existing patterns and validate that the updates comply with Android/iOS style guides.
8. **Document** — if any changes go beyond current documentation in `AGENTS.md` or `ARCHITECTURE.md`, **update those files immediately** to reflect new patterns, practices, or architectural decisions. **Do NOT create separate summary files**—document changes in commit messages using Conventional Commits format.

If any linting, formatting, test, or validation command fails at step 5 (or later), fix the underlying issues, run the appropriate formatter (`dart format .` / `flutter format`), and re-run the failing checks until they pass—never leave failed stages unresolved.

**Critical**: Before making any architectural changes, check if they're documented. If not, document them first. All agents must strictly follow documented practices.

Pause and surface uncertainties; do not invent data or skip validation.

---

## 3. Architecture Alignment Checklist

- Respect the layered layout (`core`, `data`, `domain`, `presentation`) as documented in `ARCHITECTURE.md` §6 and §8–9.
- Keep the domain layer pure Dart—no Flutter imports or platform calls.
- Enforce cross-platform parity per `ARCHITECTURE.md` §7; document and review any platform-specific branches or dependencies.
- **Focus on Widget Architecture**: Use `AdaptiveWidgetFactory` for cross-platform UI adaptation instead of complex design patterns.
- **Repository Pattern**: Apply repository patterns consistently; explain caching or fallback logic using the educational comment style (`ARCHITECTURE.md` §9).
- Favor loose coupling in domain use cases (`ARCHITECTURE.md` §8); depend on abstractions and keep constructors interface-driven.
- Follow release governance (`ARCHITECTURE.md` §20): validate SemVer bumps, ensure `CHANGELOG.md` updates, and only ship via the release workflow.
- For UI work, emphasize state management decisions and avoid business logic inside widgets; push behavior into view models/use cases.
- Reconcile every meaningful change against the architecture described in `ARCHITECTURE.md`; escalate mismatches to the human collaborator.
- **Documentation Sync**: If implementing any pattern, practice, or architectural decision not described in `AGENTS.md` or `ARCHITECTURE.md`, **update those documents immediately** before completing the change.

---

## 4. Architecture Guidelines

### 4.1 Adaptive Widget Factory & Strategy Pattern
- **Purpose**: Create platform-specific UI components with consistent interfaces using Factory + Strategy patterns
- **Location**: `lib/presentation/widgets/adaptive/`
- **Structure**: Each widget has its own folder containing both factory and strategy:
  ```
  button/
    ├── adaptive_button_factory.dart  # Public API
    └── button_strategy.dart          # Platform implementations
  ```
- **Angular Analogy**: Similar to Angular's platform detection service + strategy injection pattern
- **Implementation**: `AdaptiveWidgetFactory` delegates to strategy classes (Material vs Cupertino implementations)

### 4.2 Repository Pattern
- **Purpose**: Abstract data access and provide consistent interface for data operations
- **Location**: `lib/domain/repositories/` and `lib/data/repositories/`
- **Angular Analogy**: Similar to Angular's service layer that abstracts HTTP calls and data management
- **Implementation**: Abstract repository interfaces with concrete implementations (Local, API, Hybrid)

### 4.3 Use Cases Pattern
- **Purpose**: Encapsulate business logic and orchestrate data flow
- **Location**: `lib/domain/usecases/`
- **Angular Analogy**: Similar to Angular's service methods that handle business logic
- **Implementation**: Use case classes that coordinate between repositories and presentation layer

---

## 5. Coding Standards

**Effective Dart & Flutter**

- Follow [Effective Dart](https://dart.dev/effective-dart) for style, documentation, usage, and API design.
- Structure Flutter apps per [Architecture Recommendations](https://docs.flutter.dev/app-architecture/recommendations), with clear data/UI separation, repository abstractions, and (as needed) domain use cases.

**Project-Specific Requirements**

- **FLUTTER-FIRST PRINCIPLE**: Code MUST follow Flutter idiomatic practices only. Angular concepts are teaching tools in documentation/comments, NOT architectural patterns.
- Honor the educational comment taxonomy; add context when new concepts appear (`ARCHITECTURE.md` §13).
- Treat comment preservation as the primary deliverable—never remove learning content without human approval (`ARCHITECTURE.md` §§12–13, 20).
- **Architecture**: Apply Factory and Strategy patterns for cross-platform adaptation. Each widget component has its own factory and strategies.
- **Modular Architecture**: Create clean separation between data, domain, and presentation layers.
- **Cross-Platform Compliance**: Ensure all UI components use adaptive abstractions for platform-specific behavior.
- When preparing a release or version bump, compare against the latest tag and propose a SemVer-compliant increment; update `CHANGELOG.md` and release notes (`ARCHITECTURE.md` §20).
- Favor immutable models (`freezed`, `built_value`, or hand-written) to support unidirectional data flow.
- Write tests and doc updates alongside behavior changes; add assertions that explain what and why.
- Run `dart format` and applicable linters before completion; document deviations.
- **Never import Angular patterns**: No DI containers, token-based registries, or Angular-specific abstractions in Flutter code. Use Flutter-native Factory + Strategy patterns instead.

**Best Practices - Core Principles**

- **YAGNI (You Aren't Gonna Need It)**: Don't add patterns, abstractions, or features until actually needed. Start simple, refactor when needed.
- **DRY (Don't Repeat Yourself)**: Extract common logic into reusable components, but only when duplication occurs more than twice.
- **KISS (Keep It Simple, Stupid)**: Prefer simple solutions over complex ones. Code should be understandable by both humans and AI agents.
- **SOLID Principles**: Follow Single Responsibility, Open/Closed, Liskov Substitution, Interface Segregation, Dependency Inversion principles when architecting solutions.
- **Occam's Razor**: When multiple solutions exist, prefer the simplest one that solves the problem.
- **Avoid Premature Optimization (APO)**: Focus on correctness and readability first, optimize later when profiled performance issues exist.

**File Organization & Co-location**

- Keep related files together. Strategies live with their factories in the same folder:
  ```
  button/
    ├── button_strategy_interface.dart    # Interface
    ├── material_button_strategy.dart     # Material implementation
    ├── cupertino_button_strategy.dart    # Cupertino implementation
    ├── button_strategy_factory.dart     # Strategy factory
    └── adaptive_button_factory.dart      # Widget factory
  ```
- Use meaningful file names that describe their purpose
- Place shared utilities in a `common/` subdirectory

**Strategy File Organization Guidelines**

- **Separate Files by Role** (applied in project): Each component (interface, implementation, factory) should be in its own file for maintainability and scalability:
  ```
  button/
    ├── button_strategy_interface.dart    # Strategy interface
    ├── material_button_strategy.dart     # Material implementation
    ├── cupertino_button_strategy.dart    # Cupertino implementation
    ├── button_strategy_factory.dart      # Strategy factory
    └── adaptive_button_factory.dart     # Widget factory
  ```

**Benefits of Separate Files:**
- ✅ **Single Responsibility**: Each file has one clear purpose
- ✅ **Scalability**: Easy to add new platform implementations (Windows, Linux, macOS, etc.)
- ✅ **Testability**: Can test each implementation independently
- ✅ **Maintainability**: Changes to one platform don't affect others
- ✅ **Clear Navigation**: Easy to find specific implementation
- ✅ **DRY Compliance**: Platform selection logic centralized in `StrategySelector`
- ✅ **Open/Closed Principle**: Adding new platforms doesn't require modifying existing factories

**Current State:**
- ✅ All widgets (`button/`, `card/`, `scaffold/`) use separate files (flexibility-first approach implemented)
- ✅ Centralized platform selection via `StrategySelector` (eliminates duplication)
- ✅ Each widget type has 5 files: interface + 2 implementations + factory + widget factory

**Flexibility in Mind:**
Always design for future growth, even if current code seems small. Separate files make it easy to:
- Add new platform implementations (e.g., Windows, Linux, macOS)
- Add new strategy variants (e.g., themed buttons, custom styles)
- Maintain and test each component independently
- Scale the codebase without breaking existing functionality

**Pattern Application Guidelines**

- **When to Use Patterns**: Apply design patterns only when they solve real problems, not for their own sake.
- **Strategy Pattern**: Use for platform-specific logic to improve testability and maintainability
- **Factory Pattern**: Use when creating objects with complex initialization or multiple variations
- **Repository Pattern**: Use to abstract data access and provide consistent interface
- **Avoid Over-Engineering**: Start simple, add patterns when duplication or complexity justifies them

**Open/Closed Principle (OCP) Compliance**

- Each widget factory is **self-contained** and doesn't require modifying central registry to add new widgets
- To add a new widget type: create `widget_type/` folder with factory + strategy
- **No central registry** that needs updating when adding functionality
- Each module is independently extensible without breaking existing code

**Style Guide Compliance**

AI agents must ensure all UI implementations comply with official platform style guides:

**Material Design 3 (Android/Web)**
- Reference: https://m3.material.io/guidelines
- Default elevation: 1dp for cards, 3dp for elevated components
- Default padding: 16dp (Material 3 spacing standard)
- Border radius: 12dp (Material 3 default for cards)
- Minimum touch target: 40dp × 40dp
- Documentation must include references to specific Material Design sections
- Comments must explain WHY values were chosen (e.g., "16dp ensures proper content breathing room per Material guidelines")

**iOS Human Interface Guidelines (HIG)**
- Reference: https://developer.apple.com/design/human-interface-guidelines
- No Material elevation - use subtle shadows instead
- Border radius: 12pt (iOS standard for cards)
- Default padding: 16pt (iOS HIG content inset standard)
- Minimum touch target: 44pt × 44pt (iOS HIG accessibility requirement)
- Use `CupertinoColors.systemBackground` for automatic light/dark mode support
- Documentation must include references to specific HIG sections
- Comments must explain differences from Material (e.g., "iOS uses shadows instead of elevation")

**Implementation Requirements:**
- Every platform-specific strategy file MUST include style guide references in comments
- Every material_card_strategy.dart MUST reference https://m3.material.io/components/cards
- Every cupertino_card_strategy.dart MUST reference iOS HIG sections
- Comments must explain specific values (why 16dp/16pt, why 12dp/12pt radius, etc.)
- Use educational comment taxonomy: `/// 🔶` for docs, `// 🔹` for syntax, `// 🧠` for insights
- Include Angular analogies when explaining style guide compliance

---

## 5. Tooling & Commands

| Command | Purpose |
|---------|---------|
| `flutter pub get` | Sync dependencies after manifest changes. |
| `flutter analyze` | Run static analysis and linting checks (must pass before commit). |
| `flutter test` | Run unit and widget suites (`test/`). |
| `flutter test --coverage` | Run tests and generate coverage report. |
| `flutter test integration_test` | Execute integration flows when changes cross layers. |
| `flutter build web` | Build web version for verification. |
| `dart format .` | Format code according to Dart style guide. **Note**: Do NOT format `.md` files with `dart format`. |
| `markdownlint` | Check and fix Markdown file formatting (Node.js). Usage: `markdownlint "**/*.md" --fix`. Configuration in `.markdownlint.json`. |
| `mdformat` | Python-based Markdown formatter. Usage: `pip install mdformat mdformat-myst && mdformat .` |
| Manual review | Check MD files manually using checklist in Step 5. No extra tools needed. |
| `dart doc` / `mkdocs serve` | Regenerate documentation when comments or guides change. |
| `flutter create card_snap_ui` | Bootstrap a fresh Flutter project if the repository needs to be regenerated from scratch (follow the setup checklist below to align with architecture guidelines). |

**Important Formatting Notes:**
- ✅ `dart format .` formats Dart files only (`.dart` extensions)
- ❌ Do NOT use `dart format` on Markdown files (`.md` extensions)
- ❌ Do NOT create separate summary `.md` files documenting recent changes
- ✅ Document changes in commit messages following Conventional Commits format
- ✅ Include detailed explanations in code comments (`///`, `//`, `// 🧠`)
- ✅ **Source of Truth**: Code comments + documentation files + commit history
- ✅ Verify MD files with markdown linters (or manual review if tools unavailable)
- ✅ **No external dependencies required**: Manual review always works, automated tools are optional

**Verification Workflow:**
Before committing changes, agents must verify based on file types changed:

**For Dart file changes** (`.dart`, generated files):
1. `flutter analyze` - No errors or warnings
2. `flutter test --coverage` - All tests pass and coverage report generated
3. `dart format .` - Code properly formatted (**Note**: Only formats `.dart` files)
4. Check coverage thresholds:
   - Domain Layer: 90%+ minimum
   - Data Layer: 80%+ minimum
   - Presentation Layer: 70%+ minimum
   - Core Layer: 85%+ minimum
5. Optionally: `flutter build web` - Build succeeds

**For Markdown file changes** (`.md`):
1. **IMPORTANT**: Check if ANY Dart files were also changed using `git diff --name-only`
2. **If ONLY Markdown files changed** (no `.dart` files in diff):
   - **DO NOT RUN** `flutter test`, `flutter analyze`, or `dart format`
   - These commands waste time on MD-only changes
3. **Then choose one:**
   - **If Node.js is available**: Run `markdownlint "**/*.md"` and `markdownlint "**/*.md" --fix`
   - **If Node.js is NOT available**: Use alternatives:
     - Manual review using the checklist below (recommended)
     - Python-based tools: `pip install mdformat mdformat-myst` then `mdformat .`
     - Use IDE's built-in Markdown linter (VS Code, IntelliJ, etc.)
     - Online tools: paste MD content to markdownlint.herokuapp.com
4. Manually review Markdown files for formatting issues
5. Check heading hierarchy, links, code blocks
6. Verify style consistency

**Documentation Policy:**
- ✅ Document changes in git commit messages (Conventional Commits format)
- ✅ Add detailed comments in code files (`///`, `//`, `// 🧠`)
- ✅ Update existing architecture docs (AGENTS.md, ARCHITECTURE.md) if patterns change
- ❌ Do NOT create separate summary files (e.g., `REFACTORING_SUMMARY.md`, `CHANGE_LOG_today.md`)
- ✅ **Source of Truth**: Code comments + existing documentation files + commit history (triple redundancy)
- ✅ At any step, you can pause to review documentation and gather context
- ✅ Verify and fix Markdown files: check for formatting issues, broken links, style consistency

Use development servers/emulators for manual verification; avoid production builds unless explicitly requested by the human.

**Commit & Push Workflow:**
After verification passes, commit and push changes:
1. Stage all changes: `git add .`
2. Commit with Conventional Commits format (see `ARCHITECTURE.md` §18):
   - `feat(scope): description` - New features
   - `fix(scope): description` - Bug fixes
   - `docs(scope): description` - Documentation updates
   - `refactor(scope): description` - Code restructuring
   - `style(scope): description` - Formatting changes
   - `test(scope): description` - Test additions/updates
   - `chore(scope): description` - Tooling/maintenance
3. Push to current branch: `git push`
4. Optionally create PR if not on main branch

**Mandatory Steps Before Push:**

**STEP 1: ALWAYS check what changed using git FIRST:**
```bash
# Check modified files
git diff --name-only HEAD

# Check if there are any .dart files changed
if git diff --name-only HEAD | grep -q "\.dart$"; then
  echo "Dart files changed - run Flutter commands"
else
  echo "NO Dart files - DO NOT run Flutter commands"
fi
```

**STEP 2: Conditional workflow based on changed files:**
- **Dart files changed** (any `.dart`, `.dart.html`, `.g.dart` files):
  - ✅ Run `flutter analyze` (must have 0 errors, 0 warnings)
  - ✅ Run `flutter test --coverage` (all tests must pass, coverage report generated)
  - ✅ Verify coverage thresholds meet minimum requirements (see `test/README.md`)
  - ✅ Run `dart format .` (code must be formatted for Dart files only)
  - ✅ Review and fix Markdown files (formatting, broken links, style consistency)
  - ✅ Follow Conventional Commits standard (see `ARCHITECTURE.md` §18)
  - ✅ Update documentation if architecture changes (AGENTS.md, ARCHITECTURE.md)

- **Markdown files ONLY** (NO `.dart` files in git diff):
  - **CRITICAL**: Do NOT run `flutter test`, `flutter analyze`, or `dart format`
  - ✅ Run `markdownlint` to check for formatting issues (if Node.js available)
  - ✅ Alternative: Use `mdformat` (Python) or IDE linting
  - ✅ Alternative: Manual review using checklist
  - ✅ Manually review Markdown files (formatting, links, consistency)
  - ✅ Follow Conventional Commits standard
  - ✅ Commit documentation changes

---

## 6. Bootstrap Checklist (Empty Repository Scenario)

1. **Initialize project:** run `flutter create card_snap_ui` in an empty workspace (do not run automatically unless the human confirms Flutter is installed).
2. **Restructure folders:** conform to `ARCHITECTURE.md` §5 by organizing `lib/` into `core/`, `data/`, `domain/`, `presentation/`, and moving CI/docs scaffolding into place.
3. **Configure dependencies:** update `pubspec.yaml` using the baseline in `ARCHITECTURE.md` §6.1, add `analysis_options.yaml`, and wire up build_runner scripts.
4. **Seed documentation:** restore `README.md`, `ARCHITECTURE.md`, `AGENTS.md`, and create/update `CHANGELOG.md` with an initial entry.
5. **Configure tooling:** add `.github/workflows/`, `infra/`, and any required configuration files referenced in the architecture guide.
6. **Verify alignment:** ensure comment taxonomy, cross-platform strategy, and release policies are reinstated before committing.

---

## 7. Communication Protocol

- Lead with findings, risks, or blockers; follow with implementation details.
- Reference files and line numbers (`path/to/file.dart:42`) when discussing code.
- Offer validation steps or command snippets the human can run to confirm behavior.
- When presenting options, list trade-offs and recommend the lowest-risk approach that preserves the teaching mission.

---

## 8. Quick Reference

- Architecture deep dive & learning goals: `ARCHITECTURE.md`
- Business requirements & SRS baseline: `BUSINESS.md`
- CI/CD & automation: `infra/`
- Documentation sources: `docs/`
- Tests: `test/`, `integration_test/`
- Release history & notes: `CHANGELOG.md`, GitHub Releases
- Legacy note: `ARCHITECTURE.md` now points to README and this playbook.

Operate transparently, teach as you go, and keep humans and AI aligned on the shared educational goals of Card Snap UI.
