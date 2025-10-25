# Infrastructure & DevOps

This directory contains infrastructure, CI/CD, and deployment configurations for Card Snap Wallet.

## 📁 Directory Structure

```
infra/
├── ci/                    # Continuous Integration
│   ├── github-actions/   # GitHub Actions workflows
│   └── scripts/          # Build and test scripts
├── deployment/           # Deployment configurations
│   ├── android/          # Android build and release
│   ├── ios/              # iOS build and release
│   └── scripts/          # Deployment scripts
├── monitoring/          # Observability and logging
│   ├── logging/          # Structured logging config
│   └── metrics/          # Performance monitoring
└── security/             # Security configurations
    ├── encryption/       # Encryption key management
    └── certificates/     # Code signing certificates
```

## 🔄 CI/CD Pipeline

### GitHub Actions Workflows

- **[Flutter CI](ci/github-actions/flutter-ci.yml)** - Linting, testing, and building
- **[Release Pipeline](ci/github-actions/release.yml)** - Automated versioning and deployment
- **[Security Scan](ci/github-actions/security.yml)** - Dependency and code security checks

### Build Scripts

- **[Android Build](ci/scripts/build-android.sh)** - Android APK/AAB generation
- **[iOS Build](ci/scripts/build-ios.sh)** - iOS IPA generation
- **[Cross-Platform Test](ci/scripts/test-cross-platform.sh)** - Multi-platform testing

## 🚀 Deployment

### Android Deployment

- **Target**: Android 9+ (API 23+)
- **Build Types**: Debug, Profile, Release
- **Signing**: Automated with GitHub Secrets
- **Distribution**: Google Play Store (future)

### iOS Deployment

- **Target**: iOS 15+
- **Build Types**: Debug, Profile, Release
- **Signing**: Automated with Apple Developer certificates
- **Distribution**: App Store (future)

## 📊 Monitoring & Observability

### Structured Logging

- **Format**: JSON with trace IDs
- **Levels**: Debug, Info, Warning, Error
- **Context**: User journey tracking
- **Storage**: Local logs with optional remote sync

### Performance Metrics

- **App Launch Time**: Cold start performance
- **Card Rendering**: Barcode display speed (<200ms requirement)
- **Storage Usage**: Local database size monitoring
- **Offline Capability**: Network state tracking

## 🔒 Security

### Encryption

- **Algorithm**: AES-256-GCM
- **Key Management**: OS-backed secure storage
- **Data at Rest**: All sensitive data encrypted
- **Key Derivation**: PBKDF2 with 100,000 iterations

### Code Signing

- **Android**: Keystore management with GitHub Secrets
- **iOS**: Apple Developer certificates
- **Verification**: Automated signature validation

## 🛠️ Development Tools

### Local Development

- **Flutter SDK**: 3.24.x (stable channel)
- **Dart SDK**: ^3.9.2
- **IDE**: VS Code with Flutter extensions
- **Testing**: Unit, widget, and integration tests

### Build Tools

- **Code Generation**: build_runner for Freezed/JSON
- **Linting**: flutter_lints with custom rules
- **Formatting**: dart format
- **Analysis**: Dart analyzer with strict mode

## 📋 TODO: Infrastructure Setup

### Immediate Tasks

1. **Set up GitHub Actions** - Configure CI/CD pipeline
2. **Configure code signing** - Android keystore and iOS certificates
3. **Implement logging** - Structured logging with trace IDs
4. **Set up monitoring** - Performance metrics collection

### Future Enhancements

1. **Automated testing** - Cross-platform test automation
2. **Release automation** - Semantic versioning and changelog generation
3. **Security scanning** - Dependency vulnerability checks
4. **Performance monitoring** - Real-time app performance tracking

## 🔗 Related Documentation

- **[Architecture Guide](../ARCHITECTURE.md)** - Technical architecture decisions
- **[Business Requirements](../BUSINESS.md)** - Product requirements and constraints
- **[Agent Playbook](../AGENTS.md)** - Development workflow and AI collaboration

---

*This infrastructure setup supports the offline-first, security-focused design of Card Snap Wallet while maintaining educational value for Flutter development.*
