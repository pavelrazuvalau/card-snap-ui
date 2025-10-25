# Card Snap Wallet Documentation

Welcome to the Card Snap Wallet documentation! This directory contains comprehensive guides for developers, especially those coming from Angular/TypeScript backgrounds.

## 📚 Documentation Structure

### Architecture & Design
- **[Architecture Overview](architecture/overview.md)** - Clean Architecture principles and layer organization
- **[Domain Layer](architecture/domain.md)** - Business logic and use cases
- **[Data Layer](architecture/data.md)** - Repository patterns and offline-first storage
- **[Presentation Layer](architecture/presentation.md)** - UI components and state management

### Development Guides
- **[Getting Started](development/getting-started.md)** - Setup and first steps
- **[Angular to Flutter](development/angular-to-flutter.md)** - Migration guide for Angular developers
- **[Testing Strategy](development/testing.md)** - Unit, widget, and integration testing
- **[Localization](development/localization.md)** - Multilingual support (ru/en/uk/pl + extended)

### Business Requirements
- **[Offline-First Design](requirements/offline-first.md)** - No network dependency
- **[Security & Encryption](requirements/security.md)** - AES-256-GCM encryption
- **[Backup & Export](requirements/backup.md)** - User-controlled data export/import
- **[Card Management](requirements/cards.md)** - QR/barcode scanning and storage

### API Reference
- **[Domain Entities](api/entities.md)** - Business models and value objects
- **[Use Cases](api/usecases.md)** - Business operations and workflows
- **[Repositories](api/repositories.md)** - Data access interfaces
- **[Widgets](api/widgets.md)** - UI components and pages

## 🎯 Quick Start for Angular Developers

If you're coming from Angular/TypeScript, start here:

1. **[Angular to Flutter Mapping](development/angular-to-flutter.md)** - Understand the conceptual differences
2. **[Architecture Overview](architecture/overview.md)** - Learn Clean Architecture in Flutter
3. **[Domain Layer](architecture/domain.md)** - Start with business logic (most familiar)

## 🔧 Development Workflow

1. **Observe** - Read relevant documentation and understand requirements
2. **Plan** - Design the feature following Clean Architecture principles
3. **Execute** - Implement with educational comments and Angular analogies
4. **Review** - Test and document the implementation

## 📖 Educational Focus

Every file in this project includes:
- **Angular/TypeScript analogies** - Connect Flutter concepts to familiar patterns
- **Educational comments** - Explain the "why" behind architectural decisions
- **Business context** - Link technical implementation to user requirements

## 🚀 Next Steps

1. Review the [Business Requirements](../BUSINESS.md) for context
2. Study the [Architecture Guide](../ARCHITECTURE.md) for technical decisions
3. Follow the [Agent Playbook](../AGENTS.md) for development workflow
4. Start implementing features following the Clean Architecture layers

---

*This documentation is part of the Card Snap Wallet educational project, designed to teach Flutter development through Angular/TypeScript analogies.*
