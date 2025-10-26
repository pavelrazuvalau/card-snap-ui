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

// Data imports
import 'data/datasources/local_card_datasource.dart';

// Presentation imports
import 'presentation/pages/card_list_page.dart';

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
Future<void> _initializeDependencies() async {
  // Initialize local data source
  final localDataSource = LocalCardDataSource();
  await localDataSource.initialize();

  // TODO: Register with dependency injection container when get_it is added
  // For now, we'll pass dependencies directly
}

/// Main application widget
/// 🔶 Root widget for the entire application
/// 🔹 Similar to Angular's AppComponent
class CardSnapApp extends StatelessWidget {
  const CardSnapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: _buildTheme(),
      home: const CardListPage(),
      // TODO: Add routing configuration
      // routes: {
      //   '/': (context) => const CardListPage(),
      //   '/add-card': (context) => const AddCardPage(),
      //   '/card-details': (context) => const CardDetailsPage(),
      // },
    );
  }

  /// Build application theme
  /// 🔹 Material Design theme configuration with Windows-style elements
  /// 🧠 Consistent with offline-first, security-focused design
  ThemeData _buildTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0078D4), // Windows blue
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xFFF3F2F1), // Windows light gray
        foregroundColor: Color(0xFF323130), // Windows dark text
      ),
      cardTheme: const CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ), // Windows-style rounded corners
        ),
        color: Color(0xFFFFFFFF), // Pure white cards
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: Color(0xFF0078D4), // Windows blue
      ),
      // Windows-style typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Color(0xFF323130),
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: Color(0xFF323130),
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Color(0xFF323130),
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF323130),
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF323130),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF605E5C),
        ),
      ),
    );
  }
}
