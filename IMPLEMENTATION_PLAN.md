# Card Snap UI — Implementation Plan

**Status:** Phase 1 (Preparation) ~90% Complete  
**Target:** MVP v0.1.0  
**Last Updated:** Current Session

---

## Phase 1: Preparation & Setup ✅ (90% Complete)

- [ ] **1.1** Commit documentation consolidation + dependency updates
  - Files: AGENTS.md, ARCHITECTURE.md, BUSINESS.md, STYLEGUIDE.md, README.md, pubspec.yaml, pubspec.lock
  - Command: `git add . && git commit -m "docs(agents,arch,business,style,readme): consolidate documentation and add code generation/storage dependencies"`
  - Acceptance: Clean git status, changes pushed to origin/develop

- [ ] **1.2** Synchronize dependencies (Blocking for code generation)
  - Commands:
    ```bash
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
  - Acceptance: No build_runner errors; .freezed.dart and .g.dart files generated

- [ ] **1.3** Establish test coverage baseline
  - Command: `flutter test --coverage`
  - Acceptance: coverage/lcov.info generated; baseline metrics recorded

---

## Phase 2: Domain Layer Implementation (Pure Dart)

### 2.1 Create Entities (`lib/domain/entities/`)

- [ ] **2.1.1** loyalty_card.dart
  - Fields: id, displayName, code, codeFormat (qr/code128/ean13/upca/pdf417), createdAt, updatedAt, storeId, notes
  - Annotations: @freezed, @immutable
  - Serialization: part 'loyalty_card.freezed.dart'; part 'loyalty_card.g.dart'
  - Reference: BUSINESS.md §5.3, STYLEGUIDE.md §8.1
  - Acceptance: @freezed compilation successful, JSON serialization tests pass

- [ ] **2.1.2** store.dart
  - Fields: id, brandName, branchName, location (city/region/country), acceptsBarcodeTypes, hasAppDeepLink, loyaltyProgramId
  - Annotations: @freezed
  - Reference: BUSINESS.md §5.3
  - Acceptance: @freezed compilation successful, model testable

- [ ] **2.1.3** backup_archive.dart
  - Fields: encryptedData, schemaVersion, createdAt, checksums
  - Annotations: @freezed
  - Reference: BUSINESS.md §4.3
  - Acceptance: @freezed compilation successful, model testable

### 2.2 Create Repository Interfaces (`lib/domain/repositories/`)

- [ ] **2.2.1** card_repository.dart
  - Methods: addCard(), getAllCards(), deleteCard(), updateCard(), searchCards()
  - Return type: Future<Result<T>> (error handling via Result pattern)
  - Reference: ARCHITECTURE.md §5, STYLEGUIDE.md §8.3
  - Acceptance: Interface defined, no implementation; abstract methods only

- [ ] **2.2.2** backup_repository.dart
  - Methods: createBackup(), restoreBackup(), validateBackup()
  - Return type: Future<Result<T>>
  - Acceptance: Interface defined, no implementation; abstract methods only

### 2.3 Create Use Cases (`lib/domain/usecases/`)

- [ ] **2.3.1** add_card_use_case.dart
  - Input: AddCardParams (displayName, code, codeFormat, storeId, notes)
  - Output: Future<Result<LoyaltyCard>>
  - Logic: Validate code format, create entity, call repository
  - Reference: BUSINESS.md §2.1 (MVP Feature 1)

- [ ] **2.3.2** search_stores_use_case.dart
  - Input: SearchStoresParams (query, location)
  - Output: Future<Result<List<Store>>>
  - Logic: Query repository, apply filters
  - Reference: BUSINESS.md §2.1 (MVP Feature 4)

- [ ] **2.3.3** create_backup_use_case.dart
  - Input: CreateBackupParams (password)
  - Output: Future<Result<BackupArchive>>
  - Logic: Encrypt all cards, generate checksums, return archive
  - Reference: BUSINESS.md §2.1 (MVP Feature 3)

- [ ] **2.3.4** restore_backup_use_case.dart
  - Input: RestoreBackupParams (backupArchive, password)
  - Output: Future<Result<List<LoyaltyCard>>>
  - Logic: Validate archive, decrypt, restore cards
  - Reference: BUSINESS.md §2.1 (MVP Feature 3)

---

## Phase 3: Data Layer Implementation

### 3.1 Create Models (`lib/data/models/`)

- [ ] **3.1.1** loyalty_card_model.dart
  - Extends: LoyaltyCard (domain entity)
  - Add: fromJson, toJson, copyWith
  - Hive Adapter: @HiveType, @HiveField annotations
  - Reference: ARCHITECTURE.md §6

- [ ] **3.1.2** store_model.dart
  - Extends: Store (domain entity)
  - Add: fromJson, toJson, copyWith
  - Reference: ARCHITECTURE.md §6

- [ ] **3.1.3** backup_archive_model.dart
  - Extends: BackupArchive (domain entity)
  - Add: JSON serialization, encryption metadata

### 3.2 Create Data Sources (`lib/data/datasources/`)

- [ ] **3.2.1** local_card_datasource.dart (Hive)
  - Methods: createCard(), readCard(), updateCard(), deleteCard(), readAllCards()
  - Storage: Hive box 'loyalty_cards'
  - Reference: ARCHITECTURE.md §6 (Offline-first)

- [ ] **3.2.2** local_backup_datasource.dart
  - Methods: saveBackup(), loadBackup(), deleteBackup()
  - Storage: Hive box 'backups'

- [ ] **3.2.3** remote_store_datasource.dart (Mock API)
  - Methods: searchStores()
  - Implementation: JSON mock data (MVP); future upgrade to real API

### 3.3 Create Repository Implementations (`lib/data/repositories/`)

- [ ] **3.3.1** card_repository_impl.dart
  - Implements: CardRepository (domain interface)
  - Dependency: LocalCardDataSource
  - Error handling: Result pattern with custom exceptions

- [ ] **3.3.2** backup_repository_impl.dart
  - Implements: BackupRepository (domain interface)
  - Dependencies: LocalBackupDataSource, encryption service
  - Error handling: Result pattern with custom exceptions

---

## Phase 4: Core Layer — Utilities & Infrastructure

### 4.1 Error Handling

- [ ] **4.1.1** result.dart
  - Classes: Result<T> (Success/Failure), Failure (message, stackTrace)
  - Reference: STYLEGUIDE.md §8.3

- [ ] **4.1.2** exceptions.dart
  - Classes: RepositoryException, ValidationException, EncryptionException

### 4.2 Encryption Service

- [ ] **4.2.1** encryption_service.dart
  - Methods: encrypt(), decrypt(), generateKey(), generateIV()
  - Algorithm: AES-256-GCM
  - Reference: ARCHITECTURE.md §6, BUSINESS.md §5.5

### 4.3 Dependency Injection

- [ ] **4.3.1** setup_service_locator.dart
  - Register: Get_It services (repositories, use cases, data sources)
  - Reference: AGENTS.md §2 (DI principles)

---

## Phase 5: Presentation Layer — BLoC & UI

### 5.1 BLoCs (`lib/presentation/blocs/`)

- [ ] **5.1.1** card_list_bloc.dart
  - Events: FetchCards, AddCard, DeleteCard, SearchCards
  - States: CardListLoading, CardListLoaded, CardListError
  - Reference: ARCHITECTURE.md §11

- [ ] **5.1.2** backup_bloc.dart
  - Events: CreateBackup, RestoreBackup
  - States: BackupLoading, BackupSuccess, BackupError
  - Reference: ARCHITECTURE.md §11

### 5.2 Pages (`lib/presentation/pages/`)

- [ ] **5.2.1** home_page.dart
  - Displays: List of loyalty cards, quick add button
  - BLoC: CardListBLoC
  - Reference: BUSINESS.md §2.1

- [ ] **5.2.2** card_detail_page.dart
  - Displays: Card details, barcode, actions (edit, delete, share)
  - Reference: BUSINESS.md §2.1

- [ ] **5.2.3** store_search_page.dart
  - Displays: Store search results, filters by location
  - BLoC: StoreSearchBLoC
  - Reference: BUSINESS.md §2.1

- [ ] **5.2.4** backup_page.dart
  - Displays: Create backup, restore from archive options
  - BLoC: BackupBLoC
  - Reference: BUSINESS.md §2.1

### 5.3 Widgets (`lib/presentation/widgets/`)

- [ ] **5.3.1** card_tile_widget.dart
  - Displays: Card preview with barcode thumbnail, tap to expand
  - Adaptive: Platform-specific styling (Material/Cupertino)

- [ ] **5.3.2** barcode_display_widget.dart
  - Displays: Barcode based on code format
  - Adaptive: Scaling for different screen sizes

- [ ] **5.3.3** adaptive widget updates
  - Ensure: All widgets use AdaptiveWidgetFactory pattern
  - Reference: ARCHITECTURE.md §8

---

## Phase 6: Testing

### 6.1 Unit Tests

- [ ] **6.1.1** domain/entities_test.dart
  - Test: Entity creation, serialization, equality
  - Coverage target: 90%

- [ ] **6.1.2** domain/usecases_test.dart
  - Test: Use case logic, error handling, Result pattern
  - Coverage target: 90%

- [ ] **6.1.3** data/repositories_test.dart
  - Test: Repository implementations with mocked data sources
  - Coverage target: 80%

### 6.2 Integration Tests

- [ ] **6.2.1** integration/card_flow_test.dart
  - Test: Add card → Display → Delete card flow
  - Reference: BUSINESS.md §4 (User Stories)

- [ ] **6.2.2** integration/backup_flow_test.dart
  - Test: Create backup → Restore flow with password

---

## Phase 7: Documentation & Final Verification

- [ ] **7.1** Update API documentation (ARCHITECTURE.md)
  - Add: Generated API docs for all public methods

- [ ] **7.2** Update Contributing Guide (AGENTS.md)
  - Add: Testing conventions, PR requirements

- [ ] **7.3** Create CHANGELOG.md
  - Add: v0.1.0-beta features and known limitations

- [ ] **7.4** Final verification
  - Commands:
    ```bash
    flutter analyze
    flutter test --coverage
    flutter build apk --release (or ios)
    ```
  - Acceptance: No errors; coverage thresholds met; build successful

---

## Git Workflow

Each phase completion:
```bash
git add <files>
git commit -m "feat(scope): description" # or docs()/tests()
git push origin develop
```

Before merging to main:
```bash
git checkout main
git pull origin main
git merge --no-ff develop
git push origin main
git tag v0.1.0-beta
```

---

## Summary

- **Total Files to Create:** ~25 Dart files + tests
- **Estimated Timeline:** 1-2 weeks (depending on testing depth)
- **Current Blocker:** Phase 1.1 commit + Phase 1.2 build_runner execution
- **Next Action:** Execute Phase 1 steps sequentially; await user confirmation between phases

---

**Legend:**
- ✅ Complete
- ⏳ In Progress
- ⚠️ Blocked
- ⬜ Not Started
