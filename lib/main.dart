/// 🔶 Main Application Entry Point
///
/// Bootstrap the Card Snap UI application with dependency injection.
/// Similar to Angular's main.ts but using Flutter's app initialization.
///
/// In Angular, you'd have:
/// ```typescript
/// import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
/// import { AppModule } from './app/app.module';
///
/// platformBrowserDynamic().bootstrapModule(AppModule);
/// ```
///
/// In Flutter/Dart, we use main() function with dependency injection.
library main;

import 'package:flutter/material.dart';

// Core imports
import 'core/constants/app_constants.dart';
import 'core/di/service_locator.dart';

// Data imports (unused for now - services registered in DI)
// import 'data/datasources/local_card_datasource.dart';

// Presentation imports
import 'presentation/pages/card_list_page.dart';
import 'presentation/widgets/adaptive/adaptive_widget_module.dart';
import 'core/platform/locale_controller.dart';

/// Main application entry point
/// 🔹 Bootstrap the Flutter application
/// 🧠 Initialize dependencies before running app
void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await _initializeDependencies();

  // Run the application
  runApp(const CardSnapApp());
}

/// Initialize dependency injection
/// 🔹 Register all services and repositories
/// 🧠 Offline-first approach - local storage is primary
/// 🧠 Uses get_it for dependency injection (similar to Angular providers)
Future<void> _initializeDependencies() async {
  await initializeDependencyInjection();
}

/// Main application widget
/// 🔶 Root widget for the entire application
/// 🔹 Similar to Angular's AppComponent
/// 🧠 Uses adaptive app factory for cross-platform theme adaptation
class CardSnapApp extends StatelessWidget {
  const CardSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔶 Use adaptive app factory for cross-platform adaptation
    // 🔹 Returns MaterialApp for Android/Web, Cupertino-styled MaterialApp for iOS
    // 🧠 This provides native look-and-feel on each platform
    // 🧠 Strategies handle their own themes internally - no configuration needed
    return ValueListenableBuilder<Locale?>(
      valueListenable: LocaleController.instance.locale,
      builder: (context, selectedLocale, _) {
        return AdaptiveAppFactory.createApp(
          title: AppConstants.appName,
          home: const CardListPage(),
          locale: selectedLocale,
          // TODO: Add routing configuration
          // routes: {
          //   '/': (context) => const CardListPage(),
          //   '/add-card': (context) => const AddCardPage(),
          //   '/card-details': (context) => const CardDetailsPage(),
          // },
        );
      },
    );
  }
}
