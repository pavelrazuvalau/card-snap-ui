# Card Snap Wallet — Business & Software Requirements

Version: 0.1.0
Last updated: 2025-10-25
Author: Pavel Razuvalau

**This document is the primary source of truth for all business requirements, functional specifications, and user acceptance criteria.**

**Related Documentation:**
- **Architecture guide:** See `ARCHITECTURE.md` for implementation patterns, clean architecture structure, and cross-platform strategies
- **AI agent playbook:** See `AGENTS.md` for how AI copilots should interpret and implement these requirements
- **Project overview:** See `README.md` for high-level project context

---

## 1. Introduction

**Purpose.** Define the business context and software requirements for Card Snap Wallet, an offline-first loyalty and discount card manager for Android 9+ and iOS 15+. The document sets the baseline for architecture, development, and QA work carried out by human and AI contributors in the Card Snap learning environment.

**Product boundaries.**

- Manages loyalty/discount cards as scannable codes plus metadata.
- Stores all customer data locally with encryption and explicit export/import flows.
- Operates without a network connection; online access enhances search and future sync but is not required for core value.
- Defers cloud synchronization to a later release while keeping architecture ready for it.
- Ships multilingual UX: primary languages Russian (ru), English (en), Ukrainian (uk), Polish (pl); extended set includes German (de), French (fr), Spanish (es), Italian (it), Dutch (nl), and Swedish (sv).

**Target audience.**

- Product, design, and engineering teams (Flutter developers who think in Angular/TypeScript patterns).
- QA and support engineers validating offline and backup experiences.
- Security, legal, and compliance reviewers ensuring GDPR readiness.

**Success criteria.**

- Users digitize physical loyalty cards and redeem them offline at checkout.
- Data remains private, encrypted, and recoverable through user-controlled backups.
- The system evolves toward multi-cloud sync without refactoring core layers.

---

## 2. Product Overview

**Primary value proposition.** Replace a bulky stack of plastic cards with a secure, encrypted mobile wallet that stays functional even when offline.

**Feature summary (MUST / SHOULD / WON’T).**

- **MUST** add cards via QR scan, 1D barcode scan, or manual entry with explicit display format selection.
- **MUST** provide offline store search with local index (no network dependency for core functionality).
- **MUST** render stored codes with pixel-equivalent fidelity in under 200 ms.
- **MUST** encrypt all sensitive data at rest (AES-256-GCM or OS-backed secure storage).
- **SHOULD** support export/import of encrypted backups initiated by the user (QR-based or archive format).
- **SHOULD** expose hooks for future cloud sync providers (see Future Scope in section 2.3).
- **WON'T** (v0.1.0) offer automatic cloud sync, online store search with facets, social sharing, or loyalty enrollment flows.

**Key differentiators.**

- Offline-first guarantee with encrypted local storage and QR-based cross-device transfer.
- Privacy-first architecture — no data leaves device without explicit user action.
- Transparent backup format (QR and archive) to build user trust and portability.
- Extensible architecture ready for cloud sync providers without core refactoring.

**Localization coverage.**

- English (`en`) — global baseline required for App Store and Play Store compliance.
- Russian (`ru`) — core audience across Eastern European loyalty ecosystems.
- Ukrainian (`uk`) — growing demand for digital wallets amid rapid mobile adoption.
- Polish (`pl`) — critical market with dense loyalty-card usage.
- German (`de`) — covers Germany, Austria, and Switzerland where loyalty card apps have strong market presence.
- French (`fr`) — serves France, Belgium, and Canada with strong coupon culture.
- Spanish (`es`) — supports Spain and Latin America loyalty programs.
- Italian (`it`) — supermarkets and pharmacies rely heavily on QR-based rewards.
- Dutch (`nl`) — Netherlands and Belgium feature high digital adoption rates.
- Swedish (`sv`) — key language across the Nordics for offline-first solutions.

---

### 2.1 MVP Features (v0.1.0)

**Core Card Management:**
- Add cards via QR/1D barcode scanning or manual entry with format selection
- Edit card metadata (name, notes, store association, visual customization)
- Delete cards with soft delete/archive capability
- Support formats: QR Code, Code128, EAN-13, UPC-A, PDF417

**Offline-First Storage:**
- All data encrypted at rest (AES-256-GCM) with device-specific keys (Android Keystore/iOS Keychain)
- No network dependency for core operations
- Fast access (< 200ms card rendering, < 100ms offline search)

**Backup & Restore:**
- Encrypted QR-based backup for offline transfer
- Encrypted archive export/import (`.zip` with cards.json, stores.json, metadata.json)
- Conflict resolution (merge/replace/skip strategies)

**Screenshot Import:**
- Image selection from photo library
- Automatic barcode/QR detection and extraction
- Batch processing and format validation

**Offline Store Search:**
- Local index with basic facets (location, barcode type, deep link availability)
- Fast search (< 100ms for 10k entries)

### 2.2 Enhanced Features (v0.1.0+)

**Enhanced Import Flow:**
- Step-by-step guidance and visual tutorials
- Real-time format validation
- Manual file import (`.json`, `.zip`, `.csv`)

**Enhanced UX:**
- Cold start < 1.0s, instant rendering < 200ms
- Rich metadata management and visual customization
- Biometric unlock (FaceID/TouchID) for sensitive operations

---

### 2.3 Future Scope (Online Search with Facets)

**Status:** Deferred to future releases. Implementation scheduled for v1.0 or later.

Online store search with faceted filtering represents a **significant architectural addition** requiring network infrastructure, API design, and real-time data synchronization. This feature is explicitly **marked for future implementation** and will not be part of the MVP (v0.1.0).

#### Planned Online Search Features
- **Faceted Search Interface** — Angular Material chip-style filters for:
  - Location (city, region, country)
  - Store type (chain vs. independent)
  - Barcode format support (QR, Code128, EAN-13, etc.)
  - Deep linking availability
  - Loyalty program integration
- **Hybrid Search Strategy** — Offline local index enriched with online results when network available
- **Real-Time Store Metadata** — Up-to-date information about store locations, accepted formats, and features
- **Location-Aware Results** — Proximity-based store suggestions using device GPS
- **API Integration** — RESTful endpoints for store search and metadata refresh

#### Online Search Architecture (Future)
- **API Endpoints** — `/v1/stores/search?q={query}&facets=location,type,accepts_barcode_type`
- **Caching Layer** — Smart caching strategy for offline availability after initial online fetch
- **Conflict Resolution** — Merging local and remote store data with version-based precedence
- **Sync Policies** — Configurable sync intervals and data retention policies

**Implementation Timeline:**
- **MVP (v0.1.0):** Offline local store index only
- **v1.0:** Online search with facets + first cloud sync provider
- **v1.1+:** Multi-provider cloud sync + advanced store analytics

**Note:** The architecture is designed to support online search without refactoring core layers. The domain layer includes abstractions for offline-first operation, and the data layer supports hybrid repository patterns that can add online augmentation without breaking existing functionality.

---

## 3. Business Requirements

**BR-1 (MUST)** Deliver a frictionless, privacy-preserving wallet experience that works without network access.  
**BR-2 (MUST)** Ensure user-owned recovery through encrypted, portable backups (QR-based or archive export).  
**BR-3 (MUST)** Provide offline store search with local index for basic store metadata lookup.  
**BR-4 (SHOULD)** Implement offline-first backup mechanisms (QR code generation and archive export) for cross-device transfer.  
**BR-5 (SHOULD)** Prepare a modular sync layer ready to host Google Drive, iCloud, Dropbox, and similar providers for future releases.  
**BR-6 (DEFERRED)** Online store search with faceted filtering is planned for v1.0 or later (see section 2.3).  
**BR-7 (WON'T)** Monetize or share user data prior to v1.0 and explicit legal approval.

**Business metrics.**

- Card addition success rate ≥ 98%.
- Backup creation success rate ≥ 95%.
- Average card open time < 200 ms on supported devices.
- ≥ 60% of monthly active users maintain at least one recent backup.

---

## 4. User Stories & Acceptance Criteria

### 4.1 Card capture

**Story:** Add a card by scanning a QR code  
GIVEN the user is on the “Add Card” screen with the camera active;  
WHEN the user scans a QR code and taps “Save”;  
THEN the card is stored locally as a QR entry, remains available offline, and the UI prompts the user to link a store.  
**Acceptance.**

- The code is persisted inside the encrypted local store.
- Opening the card renders a QR identical to the original (pixel comparison or checksum validation).
- Code rendering completes in under 200 ms on reference devices.
- The UI exposes a “Link store” call-to-action that opens the store search flow.

**Story:** Enter a code manually and choose its display format  
GIVEN the code cannot be captured correctly via scanning;  
WHEN the user types the value manually and selects the “Barcode (1D)” display format;  
THEN opening the saved card shows the code as a 1D barcode ready for checkout scanners.  
**Acceptance.**

- Format validation runs before saving (checksum, length, allowed characters).
- The rendered barcode matches the selected standard (EAN-13, Code128, etc.).
- The user can edit the saved display format later.

### 4.2 Store search

**Story:** Search stores with facets  
GIVEN the user types “Zabka” in the store search field;  
WHEN the system executes the search;  
THEN results surface all locations, display facets such as location, accepts_barcode_type, and has_app_deeplink, and the user can filter by city before linking the card to a specific branch.  
**Acceptance.**

- The offline index returns at least five results in ≤ 100 ms when local data is present.
- With network connectivity, the system fetches remote results and facets, merging them seamlessly in the UI.
- Users can choose “All locations” or a focused branch; the chosen binding persists with the card.
- Metadata includes accepts_barcode_type, has_app_deeplink, loyalty_program_id when available.

### 4.3 Backup

**Story:** Create an encrypted backup archive  
GIVEN the user opens Settings → “Backup & Restore”;  
WHEN they select “Create backup”, provide a password, and confirm;  
THEN the app produces a zip archive (cards.json, metadata.json, images/) and lets the user save or share the file.  
**Acceptance.**

- The archive is encrypted using PBKDF2-derived AES-256-GCM.
- metadata.json contains the schema version plus a hash per card entry.
- Export completes within 5 seconds for a library of 200 cards on reference hardware.

### 4.4 Restore

**Story:** Import a backup archive  
GIVEN the user picks a backup file;  
WHEN the user enters the correct password;  
THEN the data decrypts, conflicts (duplicates or outdated entries) are surfaced, and the user chooses a merge strategy (merge/replace).  
**Acceptance.**

- Incorrect passwords trigger friendly errors without leaking information.
- Conflicts display timestamps and store bindings before resolution.
- Imports refresh the offline store index if the archive contains newer metadata.

---

## 5. Software Requirements Specification (SRS)

### 5.1 Functional Requirements

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-1 | The system MUST allow adding a card by scanning a QR code and persist the result locally. | MUST |
| FR-2 | The system MUST support scanning 1D barcodes (Code128, EAN-13, UPC-A). | MUST |
| FR-3 | The system MUST provide manual code entry with a required display-format selector (QR vs 1D). | MUST |
| FR-4 | Users SHOULD be able to edit card metadata (name, notes, display format) after saving. | SHOULD |
| FR-5 | The app MUST deliver offline store search with facets generated from a local index. | MUST |
| FR-6 | When online, the app SHOULD augment search results with remote data and facets. | SHOULD |
| FR-7 | Users MUST be able to associate a card with a store/location and view that association. | MUST |
| FR-8 | The app MUST create encrypted backups and support re-import. | MUST |
| FR-9 | The system SHOULD offer conflict resolution strategies during import (merge vs overwrite). | SHOULD |
| FR-10 | The architecture SHOULD support plug-in sync providers for future cloud integrations. | SHOULD |
| FR-11 | The system SHOULD open specific cards via deep links. | SHOULD |
| FR-12 | When the camera is unavailable, the app MUST offer manual entry as a fallback. | MUST |
| FR-13 | The app WON’T support favorites before v1.0 (future roadmap). | WON’T |

### 5.2 Non-Functional Requirements

- **Security (MUST).** Encrypt all data at rest with AES-256-GCM using keys stored in Android Keystore/iOS Keychain. Offer biometric gating (FaceID/TouchID) as an optional unlock path.
- **Performance (MUST).** Cold start < 1.0 s (Pixel 4a, iPhone 12). Card open time < 200 ms. Offline search ≤ 100 ms.
- **Reliability (MUST).** Backup/restore operations must log outcomes and notify the user of success or failure. Automated tests cover critical flows end-to-end.
- **Usability (MUST).** Adding a card requires ≤ 3 steps. Educational tooltips frame Flutter concepts in Angular terms (e.g., “Card detail behaves like a component with its own state”).
- **Localization (MUST).** Provide full UI and content localization for Russian (ru), English (en), Ukrainian (uk), and Polish (pl); bundle secondary translations for German (de), French (fr), Spanish (es), Italian (it), Dutch (nl), and Swedish (sv) with parity in core flows.
- **Scalability (SHOULD).** Support at least 500 stored cards without UX degradation.
- **Maintainability (SHOULD).** Implement Clean Architecture layering (core/data/domain/presentation) per `ARCHITECTURE.md`.
- **Portability (SHOULD).** Ship on Android 9+ and iOS 15+ with platform variance only for camera and secure storage bridges.

### 5.3 Data Models

**Core Entities:**
- **LoyaltyCard** - Card entity with barcode data, metadata, timestamps, encryption info. Required fields: `id`, `displayName`, `code`, `codeFormat`, `createdAt`, `updatedAt`, `encryption`. Supports formats: `qr`, `code128`, `ean13`, `upca`, `pdf417`.
- **Store** - Merchant/store with location data, barcode format support, deep link info. Required fields: `id`, `brandName`, `countryCode`.
- **BackupArchive** - Encrypted backup with schema versioning. Structure: `cards.json`, `stores.json`, `metadata.json`, `images/` (optional).

**Encryption:** All sensitive data encrypted with AES-256-GCM. Keys stored in Android Keystore/iOS Keychain. Backup archives use PBKDF2-derived keys (≥ 150k iterations).

**Full JSON schemas:** See `docs/data-models.md` for complete schemas and validation rules.

### 5.4 Local Storage Structure

**Storage:** SQLite (`sqflite`) with SQLCipher encryption. Tables: `cards` (encrypted code BLOB), `stores`, `facets_index` (offline search), `settings` (backup timestamps, sync flags).

**Full schema:** See `docs/schema.md` for complete table definitions and relationships.

Domain repositories expose immutable models (`freezed`) maintaining clean architecture boundaries.

### 5.5 Sync & Backup Interfaces

**Backup Service API (local).**

- `createBackup(password: String): BackupDescriptor`
- `restoreBackup(fileUri: Uri, password: String, strategy: MergeStrategy): RestoreResult`
- `validateBackup(fileUri: Uri): ValidationResult`

**Future Cloud Sync Abstraction.**

```typescript
// Angular analogy: Injectable service interface with provider-specific implementations.
abstract class CloudSyncProvider {
  Future<void> authenticate(Credential credential);
  Future<SyncSummary> push(EncryptedArchive archive);
  Future<EncryptedArchive?> pull(DateTime since);
  Future<void> revoke();
}
```

**Remote search API (online augmentation).**

- `GET /v1/stores/search?q={query}&country={countryCode}&facets=location,type,accepts_barcode_type,has_app_deeplink`
- `GET /v1/stores/{storeId}`

Sample response with facets:

```json
{
  "query": "zabka",
  "results": [
    {
      "id": "d9e6c9a4-61b9-4d59-bb5e-8c67443331f5",
      "brandName": "Żabka",
      "branchName": "Warszawa Marszałkowska 10",
      "location": { "city": "Warszawa", "region": "Mazowieckie", "countryCode": "PL" },
      "acceptsBarcodeTypes": ["qr", "code128"],
      "hasAppDeepLink": true,
      "appDeepLink": "zabka://loyalty/12345",
      "loyaltyProgramId": "zabka-green"
    }
  ],
  "facets": {
    "location.city": [
      { "value": "Warszawa", "count": 12 },
      { "value": "Kraków", "count": 7 }
    ],
    "accepts_barcode_type": [
      { "value": "qr", "count": 32 },
      { "value": "code128", "count": 18 }
    ],
    "has_app_deeplink": [
      { "value": true, "count": 15 },
      { "value": false, "count": 20 }
    ],
    "type": [
      { "value": "chain", "count": 25 },
      { "value": "local", "count": 10 }
    ]
  },
  "latencyMs": 85,
  "cacheTtlSeconds": 3600
}
```

---

## 6. UI / UX Flows

- **Add Card wizard.**
  1. Entry screen with CTAs: Scan QR, Scan Barcode, Enter Manually.
  2. Scan mode shows framing guides; failure triggers a “Switch to manual entry” prompt.
  3. Manual entry modal offers text input, format dropdown with previews, and validation summary.
  4. Post-capture review displays the rendered code, suggested name, notes field, and “Link store” action.

- **Store search with facets.**
  - Angular analogy: similar to `MatChips` filter sets toggled in a sidebar.
  - Components: search field, infinite list, facet panel (location, type, accepts format, has deep link), optional map preview (v1).
  - Offline: results from the local index with facets built from `facets_index`. Online: remote data merges with local results using badges to show freshness.

- **Card detail view.**
  - Full-screen renderer (Canvas or `qr_flutter` / `barcode_widget`), brightness boost toggle, quick actions for map, call, or deep link.
  - Display backup status and last sync timestamp.

- **Backup & restore flow.**
  - Settings → Backup screen shows last backup, storage location, create backup button.
  - Password prompt with strength indicator (Angular analogy: form validation states).
  - Restore flow: file picker → password entry → conflict resolver list (merge/replace toggles).

- **Home widget (stretch goal).**
  - Quick access to pinned cards or favorites (v1). Not part of MVP but design should allow incremental addition.

Use Material You components for Android and Cupertino styling for iOS while sharing core presentation logic.

---

## 7. Security Requirements

- **Encryption.**
  - Primary data store uses AES-256-GCM with per-record IV and authentication tag.
  - Keys generated per device; stored via Android Keystore (StrongBox when available) or iOS Keychain (`kSecAttrAccessibleWhenUnlocked`).
  - Optional biometric gate controls key access; fallback is device PIN.

- **Secure backups.**
  - Derive encryption keys with PBKDF2 (≥ 150k iterations) from the user’s password.
  - Include a SHA-256 checksum manifest to detect tampering.

- **Permissions management.**
  - Camera, scoped storage/document picker, photo library (iOS). Clearly explain offline usage.

- **GDPR compliance.**
  - No personal data leaves the device without explicit user action.
  - Provide “Export data” and “Delete all data” options.
  - Document legal basis: legitimate interest (user-controlled storage) plus consent for optional analytics.

- **Deep link testing commands.**
  - Android: `adb shell am start -a android.intent.action.VIEW -d "cardsnap://card/{cardId}"`
  - iOS: `xcrun simctl openurl booted "cardsnap://card/{cardId}"`

- **Audit trail.**
  - Maintain a rotating local log for backup/import operations (user-readable only).

---

## 8. Performance Targets

- Cold start (no warm caches) < 1.0 s.
- Resume from background to card list < 100 ms.
- Card renderer open < 200 ms.
- Offline search latency < 100 ms with 10k store entries.
- Backup export (200 cards) ≤ 5 s; import ≤ 6 s.
- Peak memory < 150 MB during scanning.
- App bundle sizes: Android AAB < 40 MB, iOS IPA < 60 MB.
- Energy: continuous camera usage ≤ 30 mAh per session; search operations remain thermally neutral.

Monitoring: run integration tests (`flutter drive` / `integration_test`) with performance assertions; evaluate Firebase Performance for opt-in telemetry later.

---

## 9. Error Handling & Edge Cases

- **Unsupported barcode format.** Explain the limitation and route to manual entry with format selection.
- **Dynamic or single-use QR codes.** Detect redirect patterns; recommend opening the merchant app via deep link.
- **Scan failure (glare, angle).** Provide retake prompts and manual entry fallback.
- **Backup import conflicts.** Offer merge (newer wins by `updatedAt`), replace, or skip; show diff preview.
- **Password mismatch.** Limit attempts, apply exponential backoff, reinforce password guidelines.
- **Insufficient storage.** Warn users and block new captures until space is freed.
- **Deep link blocked by merchant change.** Catch failures and fall back to web/app-store links.
- **Certificate pinning mismatch for remote search.** Retry with pinned bundle fallback; rely on offline index if remote fails.
- **Localization gaps.** Default to English strings when translations are missing.

---

## 10. Extensibility & Roadmap

| Capability | MVP (v0.1.0) | v1.0 | v2.0 |
|------------|--------------|------|------|
| Card capture | QR + barcode scanning, manual entry | Auto-detect format, image OCR for card numbers | Dynamic code refresh via merchant APIs |
| Store search | Offline index with basic facets | Online enrichment, map preview | Personalized recommendations, opening hours sync |
| Localization | Core UI in ru/en/uk/pl with shared glossary | Add de/fr/es/it/nl/sv parity, automated screenshot QA | Continuous translation sync + region-specific campaigns |
| Backup | Local encrypted export/import | Cloud provider modules (Drive, iCloud) | Automatic scheduled backups + multi-device sync |
| Analytics | None (privacy first) | Opt-in local insights dashboard | Privacy-preserving aggregated analytics |
| Widgets/Wearables | Not included | Home screen widget | Wear OS / watchOS companion |
| Enterprise | Not included | Admin portal for managed devices | MDM integration, centralized policy controls |

Future-ready architecture includes plugin interfaces for merchant-specific logic (e.g., Żabka module validating dynamic codes).

---

## 11. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Dynamic or one-time QR codes expire after capture | Users cannot redeem the card | Detect dynamic URLs and warn users; surface deep links to official merchant apps. |
| Merchants block app-specific deep links | Reduced convenience | Keep store metadata updated; fall back to website or navigation actions. |
| Barcode libraries misread under poor lighting | Incorrect codes saved | Offer brightness boost, contrast enhancements, and manual correction flow. |
| Backup password is lost | Data becomes unrecoverable | Educate users, recommend password managers, allow creating a new backup while the app remains unlocked. |
| Reverse engineering of local files | Privacy breach | Apply strong encryption, obfuscation, integrity checks. |
| Certificate pinning failure on remote search API | Online search unavailable | Provide retry with bundled pins and fall back to offline index. |
| Evolving privacy/legal guidance | Compliance gaps | Schedule periodic legal reviews; modularize consent flows. |

---

## 12. MVP Backlog & Acceptance

**Release target:** v0.1.0 (MVP).  
**Definition of done:** All MUST requirements satisfied, QA sign-off complete, documentation updated (`ARCHITECTURE.md` references and agent playbooks aware of backup flow).

| Epic | User Stories / Tasks | Estimate | Priority |
|------|----------------------|----------|----------|
| Card Capture | Implement camera scanning for QR + 1D barcodes (FR-1/FR-2); manual entry + format selector (FR-3); fallback handling | 3 sprints | MUST |
| Card Storage | Encrypted SQLite schema, repository layer, rendering widget | 2 sprints | MUST |
| Store Index | Local store index ingestion, search UI with facets, remote search stub | 2 sprints | MUST |
| Backup | Export/import encrypted zip, password UI, conflict resolver | 3 sprints | MUST |
| Settings & Security | Permission dialogs, biometric unlock, data wipe | 1 sprint | MUST |
| QA & Tooling | Unit + widget tests, integration coverage for backup/restore, performance benchmarks | 2 sprints | MUST |

**QA acceptance checklist.**

- Automated tests cover scan → save → render flow end-to-end.
- Manual regression matrix includes Android 9/13 and iOS 15/17.
- Backup restore validated against corrupt archives, wrong passwords, and merge conflicts.
- Performance benchmarks executed via `flutter drive` or `integration_test`.

**Open items for v1.0.**

- Implement cloud provider plug-ins.
- Home widget and favorites support.
- Deliver full localization coverage for de, fr, es, it, nl, sv while hardening ru/en/uk/pl QA.

---

## 13. References

- Card Snap `ARCHITECTURE.md` §§5–9 (layering), §13 (comment taxonomy), §20 (release governance).
- Flutter scanning libraries: `camera`, `google_mlkit_barcode_scanning`.
- Encryption packages: `flutter_secure_storage`, `cryptography`, `sqlcipher`.
- Angular analogy: treat repositories like Angular services, view models like NgRx facades, and code renderers like standalone components.

---

This document equips AI copilots (Cursor, GitKraken MCP) with shared context while implementing Card Snap Wallet features. Keep it updated alongside feature changes to preserve traceability.
