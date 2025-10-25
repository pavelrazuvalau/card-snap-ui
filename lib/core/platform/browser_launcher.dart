/// 🔶 Platform Browser Launcher Interface
///
/// Abstraction for launching the app in different browsers across platforms.
/// Similar to Angular's platform injection services that adapt behavior based on environment.
///
/// In Angular, you'd have:
/// ```typescript
/// @Injectable({ providedIn: 'root' })
/// export class BrowserLauncherService {
///   async launch(browser: BrowserType): Promise<void> { /* ... */ }
/// }
/// ```
///
/// In Flutter/Dart, we use abstract classes to define contracts,
/// implementing platform-specific logic behind adapters.
library core.platform.browser_launcher;

/// Browser types supported by the application
/// 🔹 Similar to Angular's environment enum (dev/staging/prod)
/// 🧠 Each platform may support different browsers based on availability
enum BrowserType {
  /// Chrome browser - available on all platforms
  chrome,

  /// Firefox browser - available on all platforms
  firefox,

  /// Safari browser - available on macOS and iOS
  safari,

  /// Microsoft Edge - available on Windows and macOS
  /// 🧠 Edge uses Chromium engine but may have platform-specific behavior
  edge,
}

/// Platform detection enum
/// 🔹 Determines which OS we're running on
enum PlatformType {
  /// Linux operating system
  linux,

  /// macOS operating system
  macos,

  /// Windows operating system
  windows,

  /// Web platform (browser)
  web,

  /// Android mobile platform
  android,

  /// iOS mobile platform
  ios,
}

/// Abstract browser launcher interface
/// 🔶 Defines the contract for launching browsers across platforms
/// 🔹 Similar to Angular's abstract service that different platforms implement
/// 🧠 Platform-specific implementations handle browser detection and launching
///
/// This abstraction allows the presentation layer to consume platform-neutral APIs,
/// just like Angular components consume services without caring about implementation.
abstract class BrowserLauncher {
  /// Launch the app in the specified browser
  ///
  /// Args:
  ///   - browser: The browser type to launch
  ///   - hotReload: Whether to enable hot reload (default: true)
  ///
  /// Returns:
  ///   - Future that completes when the browser launches
  ///
  /// Throws:
  ///   - Exception if the browser is not available on this platform
  Future<void> launch({required BrowserType browser, bool hotReload = true});

  /// Get list of browsers available on this platform
  /// 🔹 Returns the browsers that can be used on the current OS
  /// 🧠 Some browsers (e.g., Safari) are only available on specific platforms
  List<BrowserType> getAvailableBrowsers();

  /// Check if a specific browser is available on this platform
  bool isBrowserAvailable(BrowserType browser);

  /// Get the current platform type
  PlatformType get currentPlatform;
}

/// 🔶 Concrete Implementation: Shell-Based Browser Launcher
///
/// Uses shell commands to launch browsers.
/// Similar to Angular's service implementation that uses browser APIs.
///
/// This is a lightweight implementation for development launchers.
/// In production, you might want to inject platform-specific adapters
/// through dependency injection (like Angular's platform injection).
class ShellBrowserLauncher implements BrowserLauncher {
  final PlatformType platform;

  ShellBrowserLauncher({required this.platform});

  @override
  Future<void> launch({
    required BrowserType browser,
    bool hotReload = true,
  }) async {
    // 🧠 Platform-specific logic would be implemented here
    // For now, this serves as a contract for shell scripts
    if (!isBrowserAvailable(browser)) {
      throw Exception('Browser $browser is not available on ${platform.name}');
    }

    // Shell script handles the actual launch
    // This Dart class documents the contract for what browsers should be supported
  }

  @override
  List<BrowserType> getAvailableBrowsers() {
    switch (platform) {
      case PlatformType.linux:
        // Linux supports Chrome, Firefox
        // 🧠 Edge is excluded from Linux per task requirements
        return [BrowserType.chrome, BrowserType.firefox];

      case PlatformType.macos:
        // macOS supports Chrome, Firefox, Safari, Edge
        return [
          BrowserType.chrome,
          BrowserType.firefox,
          BrowserType.safari,
          BrowserType.edge,
        ];

      case PlatformType.windows:
        // Windows supports Chrome, Firefox, Edge
        return [BrowserType.chrome, BrowserType.firefox, BrowserType.edge];

      case PlatformType.web:
        // Web platform (running in browser) - all browsers supported
        return BrowserType.values;

      case PlatformType.android:
      case PlatformType.ios:
        // Mobile platforms don't support web browser launching
        return [];
    }
  }

  @override
  bool isBrowserAvailable(BrowserType browser) {
    return getAvailableBrowsers().contains(browser);
  }

  @override
  PlatformType get currentPlatform => platform;
}

/// 🔶 Browser Launcher Configuration
///
/// Centralized configuration for browser support across platforms.
/// Similar to Angular's environment-specific configuration files.
///
/// This class maintains the mapping between platforms and their supported browsers,
/// making it easy to add or remove browser support without changing shell scripts.
class BrowserConfig {
  /// Map of platform to supported browsers
  /// 🔹 Configuration-driven approach allows easy toggling of browser support
  /// 🧠 Centralized config prevents scattered conditionals in code
  static final Map<PlatformType, List<BrowserType>> platformBrowsers = {
    PlatformType.linux: [BrowserType.chrome, BrowserType.firefox],
    PlatformType.macos: [
      BrowserType.chrome,
      BrowserType.firefox,
      BrowserType.safari,
      BrowserType.edge,
    ],
    PlatformType.windows: [
      BrowserType.chrome,
      BrowserType.firefox,
      BrowserType.edge,
    ],
    PlatformType.web: BrowserType.values,
    PlatformType.android: [],
    PlatformType.ios: [],
  };

  /// Get browsers for a specific platform
  static List<BrowserType> getBrowsersForPlatform(PlatformType platform) {
    return platformBrowsers[platform] ?? [];
  }

  /// Check if a browser is supported on a platform
  static bool isBrowserSupportedOnPlatform(
    BrowserType browser,
    PlatformType platform,
  ) {
    return platformBrowsers[platform]?.contains(browser) ?? false;
  }
}
