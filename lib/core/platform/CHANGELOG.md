# Platform Layer Changelog

## [0.1.0] - 2025-01-XX

### Added
- **Browser Launcher Abstraction** (`browser_launcher.dart`)
  - Abstract `BrowserLauncher` interface for platform-neutral browser launching
  - `ShellBrowserLauncher` implementation for development launcher scripts
  - `BrowserConfig` centralized configuration for browser support
  - Platform detection utilities (`PlatformType` enum)
  - Browser type enumeration (`BrowserType` enum)

### Browser Support Matrix
| Platform | Chrome | Firefox | Safari | Edge |
|----------|--------|---------|--------|------|
| Linux    | ✅     | ✅      | ❌     | ❌   |
| macOS    | ✅     | ✅      | ✅     | ✅   |
| Windows  | ✅     | ✅      | ❌     | ✅   |
| Web      | ✅     | ✅      | ✅     | ✅   |

### Architectural Decisions
- **Edge removed from Linux**: Focused on most relevant browser options for Linux developers
- **Configuration-driven**: Browser support is controlled by `BrowserConfig` map, preventing scattered conditionals
- **Abstracted contracts**: Presentation layer consumes platform-neutral APIs
- **Educational focus**: Extensive comments explaining Angular/TypeScript analogies

### Updated Files
- `run_web.sh` - Added Firefox/Safari support, removed Edge from Linux
- `run_web.bat` - Added Firefox support for Windows
- `run_app.ps1` - Added Firefox support for PowerShell users
- `README.md` - Updated with new browser support
- `TROUBLESHOOTING_FINAL.md` - Updated browser matrix
- `MOBILE_SETUP.md` - Updated quick start instructions

### Angular/TypeScript Analogies
- `BrowserLauncher` interface = Angular's abstract service class
- `BrowserConfig` = Angular's environment configuration
- Platform detection = Angular's `@Inject(PLATFORM_ID)` pattern
- Shell launcher = Angular service implementation using platform APIs

