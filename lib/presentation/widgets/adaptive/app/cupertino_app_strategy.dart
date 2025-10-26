/// 🔶 Cupertino App Strategy
///
/// Provides iOS-style root app widget implementation.
/// Reference: https://developer.apple.com/design/human-interface-guidelines
///
/// iOS Human Interface Guidelines app configuration applied:
/// - Uses CupertinoThemeData for iOS theme
/// - Provides iOS-native look and feel
/// - Supports iOS platform exclusively
///
/// Angular analogy: No direct Angular equivalent (iOS-specific), but similar to
/// a custom app component that adapts to iOS platform conventions.
///
/// 🧠 NOTE: MaterialApp can also wrap Cupertino widgets, so we use MaterialApp with
/// Cupertino theme for better compatibility with adaptive widgets.
/// However, for true native experience, we could use CupertinoApp wrapper.
library presentation.widgets.adaptive.app.cupertino;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'app_strategy_interface.dart';

/// Cupertino (iOS) app strategy implementation
/// 🔹 Uses MaterialApp with Cupertino theme for iOS platform
/// 🔹 Follows iOS Human Interface Guidelines
/// 🧠 MaterialApp with Cupertino theme provides best compatibility
/// 🧠 with adaptive widgets while maintaining iOS-native appearance
class CupertinoAppStrategy implements AppStrategy {
  @override
  Widget buildApp({
    required String title,
    required Widget home,
    Map<String, WidgetBuilder>? routes,
  }) {
    // 🧠 Cupertino strategy creates its own iOS-specific theme
    // 🔹 Theme is fully encapsulated within this strategy
    final cupertinoTheme = _buildCupertinoTheme();
    final darkCupertinoTheme = _buildDarkCupertinoTheme();

    return MaterialApp(
      title: title,
      theme: cupertinoTheme,
      darkTheme: darkCupertinoTheme,
      home: home,
      routes: routes ?? {},
      debugShowCheckedModeBanner: false,
    );
  }

  /// Build Cupertino-inspired theme for iOS
  /// 🔹 Creates iOS-specific theme configuration
  /// 🧠 Uses iOS system colors and typography
  ThemeData _buildCupertinoTheme() {
    return ThemeData(
      // Use Cupertino system colors
      primaryColor: CupertinoColors.systemBlue,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
      brightness: Brightness.light,

      // Use system fonts for iOS feel
      fontFamily: '.SF Pro Text', // iOS system font
      // Cupertino-style app bar
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: CupertinoColors.systemBackground,
        foregroundColor: CupertinoColors.label,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),

      // Cupertino-style cards
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        color: CupertinoColors.systemBackground,
      ),

      // Cupertino-style buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CupertinoColors.systemBlue,
          foregroundColor: CupertinoColors.white,
          elevation: 0,
        ),
      ),

      // Cupertino-style typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: CupertinoColors.label,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: CupertinoColors.secondaryLabel,
        ),
      ),
    );
  }

  /// Build dark Cupertino theme for iOS
  /// 🔹 Creates iOS-specific dark theme configuration
  /// 🧠 Uses iOS dark mode colors and typography
  ThemeData _buildDarkCupertinoTheme() {
    return ThemeData(
      // Use Cupertino dark system colors
      primaryColor: CupertinoColors.systemBlue,
      scaffoldBackgroundColor: CupertinoColors.systemBackground.darkColor,
      brightness: Brightness.dark,

      // Use system fonts for iOS feel
      fontFamily: '.SF Pro Text', // iOS system font
      // Cupertino-style dark app bar
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: CupertinoColors.systemBackground.darkColor,
        foregroundColor: CupertinoColors.label.darkColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
      ),

      // Cupertino-style dark cards
      cardTheme: const CardThemeData(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        color: CupertinoColors.secondarySystemBackground,
      ),

      // Cupertino-style dark typography
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.label,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: CupertinoColors.label,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: CupertinoColors.secondaryLabel,
        ),
      ),
    );
  }
}
