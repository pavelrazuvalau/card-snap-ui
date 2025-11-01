# Changelog

All notable changes to Card Snap UI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [0.0.1-nightly.20251101] - 2025-11-01

### Added
- CI/CD infrastructure setup
- GitHub Actions workflows (feature, develop, main branches)
- Automated Android builds (APK/AAB)
- Pre-commit hooks (branch naming, formatting, commit message validation)
- CHANGELOG validation scripts
- Build number automation script
- GitHub Releases automation

### Infrastructure
- GitHub Actions workflows for automated testing and building
- Pre-commit hooks for code quality enforcement
- Automated release creation via GitHub Releases
- Nightly builds workflow for develop branch
- Release builds workflow for main branch

---

## [0.0.1] - 2025-01-XX

### Added
- Initial project structure with Clean Architecture (core, data, domain, presentation layers)
- Flutter project configuration with dependencies (flutter_bloc, get_it, equatable)
- Localization setup with ARB files for English (en), Russian (ru), Ukrainian (uk), Polish (pl)
- Adaptive widget factory pattern for cross-platform UI (Material/Cupertino strategies)
- Basic card entity and repository interfaces
- Platform detection and browser launcher abstraction
- Basic test structure (unit, widget, integration)
- Documentation framework (ARCHITECTURE.md, BUSINESS.md, STYLEGUIDE.md, AGENTS.md)
- CI/CD pipeline infrastructure setup
- GitFlow branching strategy configuration

### Infrastructure
- Flutter SDK 3.9.2+ environment setup
- Analysis options and linting configuration
- Code coverage requirements per layer (Domain 90%+, Data 80%+, Presentation 70%+, Core 85%+)
- Development scripts for web/mobile platforms
- GitHub Actions workflows for feature, develop, and main branches
- Automated Android builds (APK/AAB) for testing
- CHANGELOG validation scripts
- GitHub Releases automation

### Documentation
- Comprehensive architecture guide with educational comments
- Business requirements specification (BUSINESS.md)
- Code style guide with Angular/TypeScript analogies
- AI agent playbook for development workflow
- Testing strategy documentation
- CI/CD pipeline documentation

---

[0.0.1]: https://github.com/yourusername/card-snap-ui/releases/tag/v0.0.1

