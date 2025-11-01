# Infrastructure & DevOps

This directory contains infrastructure, CI/CD, and deployment configurations for Card Snap UI.

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

All workflows are located in `.github/workflows/`:

- **[Feature Branch CI](../.github/workflows/feature.yml)** - Automatic checks on push + manual Android builds
  - **Triggers:** `push` to `feature/**` (checks only), `workflow_dispatch` (manual build)
  - **Actions:** Lint, format, tests, coverage checks, optional Android build
  - **Artifacts:** APK/AAB for manual builds (stored as workflow artifacts, 7 days retention)

- **[Develop Branch CI (Nightly)](../.github/workflows/develop.yml)** - Nightly Android builds
  - **Triggers:** `push` to `develop`
  - **Actions:** CHANGELOG validation, lint, tests, Android build, GitHub Release creation
  - **Releases:** Pre-release with tag format `nightly-YYYYMMDD-<commit-sha>`
  - **Artifacts:** APK/AAB attached to GitHub Release

- **[Main Branch CI (Releases)](../.github/workflows/main.yml)** - Stable release builds
  - **Triggers:** `push` to `main`
  - **Actions:** CHANGELOG validation, lint, tests, Android build, GitHub Release creation
  - **Releases:** Stable release with tag format `vX.Y.Z`
  - **Artifacts:** APK/AAB attached to GitHub Release

### Validation Scripts

- **[CHANGELOG Validator](../.github/scripts/validate-changelog.sh)** - Validates CHANGELOG.md entries
  - Checks for release versions in `main` branch
  - Checks for nightly versions in `develop` branch
  - Runs early in workflow (before tests) for fast failure

- **[Build Number Generator](../.github/scripts/get-build-number.sh)** - Auto-increments build numbers
  - Used for feature branch manual builds
  - Searches previous builds to determine next number
  - Format: `app-{branch-name}-{YYYY-MM-DD}-{number}.apk/aab`

### iOS Builds

iOS builds are **prepared but disabled** in all workflows. To enable:

1. **Subscribe to Apple Developer Program** ($99/year)
2. Create certificates and provisioning profiles
3. Store in GitHub Secrets:
   - `APPLE_DEVELOPER_CERTIFICATE_BASE64`
   - `APPLE_DEVELOPER_CERTIFICATE_PASSWORD`
   - `APPLE_PROVISIONING_PROFILE_BASE64`
   - `APPLE_APP_ID`
4. Uncomment iOS build steps in workflows
5. Switch runner to `macos-latest`

See workflow comments for detailed instructions.

## 🚀 Deployment

### Android Deployment

- **Target**: Android 9+ (API 23+)
- **Build Types**: Release (unsigned for testing)
- **Signing**: Currently unsigned (free, no registration required)
- **Distribution**: 
  - Feature builds: Workflow artifacts (manual download)
  - Nightly builds: GitHub Releases (pre-release)
  - Stable releases: GitHub Releases (latest)
- **Future**: Signing with keystore for Google Play Store (when ready)

### iOS Deployment

- **Target**: iOS 15+
- **Build Types**: Release (requires Apple Developer Program)
- **Signing**: Requires Apple Developer Program ($99/year)
- **Status**: Prepared but disabled (uncomment workflow steps when ready)
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

## ✅ Completed: Infrastructure Setup (v0.0.1)

### Implemented

1. ✅ **GitHub Actions CI/CD** - Three workflows (feature, develop, main)
2. ✅ **Automated Android builds** - APK/AAB generation for all branches
3. ✅ **GitHub Releases automation** - Nightly and stable releases
4. ✅ **CHANGELOG validation** - Automated checks before releases
5. ✅ **Code coverage checks** - Enforced per-layer thresholds
6. ✅ **Build number automation** - Auto-increment for feature builds
7. ✅ **iOS preparation** - Workflow steps prepared (disabled)

### Future Enhancements

1. **Code signing** - Android keystore and iOS certificates (when ready for store)
2. **Security scanning** - Dependency vulnerability checks
3. **Performance monitoring** - Real-time app performance tracking
4. **Structured logging** - JSON logs with trace IDs
5. **Metrics collection** - App launch time, rendering performance

## 🔗 Related Documentation

- **[Architecture Guide](../ARCHITECTURE.md)** - Technical architecture decisions
- **[Business Requirements](../BUSINESS.md)** - Product requirements and constraints
- **[Agent Playbook](../AGENTS.md)** - Development workflow and AI collaboration

---

*This infrastructure setup supports the offline-first, security-focused design of Card Snap UI while maintaining educational value for Flutter development.*
