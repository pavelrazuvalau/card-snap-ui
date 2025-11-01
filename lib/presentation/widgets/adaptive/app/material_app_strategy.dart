/// 🔶 Material App Strategy
///
/// Provides Material Design root app widget implementation.
/// Reference: https://m3.material.io/guidelines
///
/// Material Design 3 app configuration applied:
/// - Uses ThemeData for Material theme
/// - Provides Material Design 3 styling
/// - Supports Android, Web, Desktop platforms
///
/// Angular analogy: Similar to Angular Material root app with Material module.
///
/// See STYLEGUIDE.md#71-material-design-3-androidweb (§7.1) for Material Design 3 compliance requirements,
/// STYLEGUIDE.md#6-localization-standards (§6) for Localization standards, and STYLEGUIDE.md#73-style-guide-documentation-requirements (§7.3) for documentation requirements.
library presentation.widgets.adaptive.app.material;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:card_snap_ui/l10n/app_localizations.dart';
import 'package:card_snap_ui/core/platform/locale_controller.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'app_strategy_interface.dart';

/// Material Design app strategy implementation
/// 🔹 Uses MaterialApp for Android, Web, Desktop platforms
/// 🔹 Follows Material Design 3 specifications
/// 🧠 This is the standard Flutter app for non-iOS platforms
/// 🧠 Theme is fully encapsulated - no need to pass from main.dart
class MaterialAppStrategy implements AppStrategy {
  @override
  Widget buildApp({
    required String title,
    required Widget home,
    Map<String, WidgetBuilder>? routes,
    Locale? locale,
  }) {
    // 🧠 Material strategy creates its own theme internally
    // 🔹 Theme is fully encapsulated within this strategy
    final theme = _buildDefaultMaterialTheme();
    final darkTheme = _buildDefaultDarkMaterialTheme();

    return MaterialApp(
      title: title,
      theme: theme,
      darkTheme: darkTheme,
      home: home,
      routes: routes ?? {},
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocaleNamesLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (deviceLocale, supported) =>
          LocaleController.resolveLocale(deviceLocale, supported),
      debugShowCheckedModeBanner: false,
    );
  }

  /// Build default Material theme
  /// 🔹 Default Material Design theme configuration
  /// 🧠 Used when no theme is provided by main.dart
  ThemeData _buildDefaultMaterialTheme() {
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
          borderRadius: BorderRadius.all(Radius.circular(8)),
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

  /// Build default dark Material theme
  /// 🔹 Default Material Design dark theme configuration
  ThemeData _buildDefaultDarkMaterialTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0078D4),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
