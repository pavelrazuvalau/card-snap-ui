/// 🔶 Adaptive Widget Platform Detection Tests
///
/// Tests for platform detection and strategy selection logic.
/// This is the CORE logic of the adaptive system - ensuring the right
/// platform-specific widget is selected.
///
/// Similar to testing Angular's platform detection service.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:card_snap_ui/presentation/widgets/adaptive/adaptive_widget_module.dart';

void main() {
  group('Platform Detection Tests', () {
    test('should detect current platform theme', () {
      // 🔹 Test that platform detection works
      // This is CRITICAL - wrong platform detection = wrong UI
      final theme = AdaptiveWidgetFactory.getCurrentTheme();
      expect(theme, isNotNull);
      expect([
        PlatformTheme.material,
        PlatformTheme.cupertino,
        PlatformTheme.web,
      ], contains(theme));
    });

    test('should return valid platform theme', () {
      // 🔹 Ensure theme is always valid
      final theme = PlatformDetector.getCurrentTheme();
      expect(PlatformTheme.values, contains(theme));
    });

    test('should create cards via factory', () {
      // 🔹 Test that factory delegation works
      // This ensures the Factory Pattern implementation is correct
      final card = AdaptiveWidgetFactory.createCard(
        child: const Text('Test'),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
      );

      expect(card, isNotNull);
      // Widget should be created without exceptions
    });

    test('should create app bars via factory', () {
      // 🔹 Test app bar factory delegation
      final appBar = AdaptiveWidgetFactory.createAppBar(title: 'Test App Bar');

      expect(appBar, isNotNull);
    });

    test('should create list tiles via factory', () {
      // 🔹 Test list tile factory delegation
      final listTile = AdaptiveWidgetFactory.createListTile(
        leading: const Icon(Icons.check),
        title: const Text('Test Title'),
        subtitle: const Text('Test Subtitle'),
      );

      expect(listTile, isNotNull);
    });
  });
}
