# Platform Layer

The **Platform Layer** encapsulates platform-specific behavior and adapters for cross-platform code. Think of this as Angular's platform injection or dependency injection that adapts behavior based on the runtime environment.

## Angular Analogy

In Angular, you'd have:
```typescript
import { PLATFORM_ID, Injectable } from '@angular/core';
import { isPlatformBrowser, isPlatformServer } from '@angular/common';

@Injectable({ providedIn: 'root' })
export class PlatformService {
  constructor(@Inject(PLATFORM_ID) private platformId: Object) {}
  
  isBrowser(): boolean {
    return isPlatformBrowser(this.platformId);
  }
}
```

## Flutter/Dart Equivalent

- **Browser launchers** (`browser_launcher.dart`) - Launch web apps in different browsers
- **Platform detection** - Determine which OS we're running on
- **Platform adapters** - Hide platform-specific code behind interfaces

## Key Principles

- **Abstraction First** - Define contracts before implementation
- **Platform Neutral APIs** - Presentation layer shouldn't know about platform differences
- **Configuration-Driven** - Browser support is controlled by config, not scattered conditionals
- **Educational Focus** - Comments explain why platform branches exist

## Browser Support Matrix

| Platform | Chrome | Firefox | Safari | Edge |
|----------|--------|---------|--------|------|
| Linux    | ✅     | ✅      | ❌     | ❌   |
| macOS    | ✅     | ✅      | ✅     | ✅   |
| Windows  | ✅     | ✅      | ❌     | ✅   |
| Web      | ✅     | ✅      | ✅     | ✅   |

> **Note:** Edge is explicitly excluded from Linux per architectural decision to keep browser choice focused on the most relevant options for that platform.

## Usage Example

```dart
// Import the platform adapter
import 'package:core/platform/browser_launcher.dart';

// Get the appropriate launcher for current platform
final launcher = getLauncherForCurrentPlatform();

// Launch app in specific browser
await launcher.launch(browser: BrowserType.firefox);

// Check available browsers
final availableBrowsers = launcher.getAvailableBrowsers();
```

## Design Rationale

Platform-specific logic is encapsulated in adapters to:
1. **Maintain Separation of Concerns** - Platform details don't leak into business logic
2. **Enable Testing** - Mock platform adapters in unit tests
3. **Teach Architecture** - Shows how dependency injection works across platforms
4. **Cross-Platform Parity** - Business logic remains the same regardless of OS

