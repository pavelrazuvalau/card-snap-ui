/// 🔶 Adaptive App Widget Tests
///
/// Tests for adaptive app widget creation and platform detection.
/// This is the CRITICAL ROOT component of the adaptive system - ensuring
/// the correct app widget (MaterialApp vs CupertinoApp) is created.
///
/// Similar to testing Angular's app component factory.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:card_snap_ui/presentation/widgets/adaptive/adaptive_widget_module.dart';

void main() {
  group('Adaptive App Factory Tests', () {
    testWidgets('should create MaterialApp for Material platform', (
      tester,
    ) async {
      // 🔹 Test that adaptive app creates MaterialApp for non-iOS platforms
      // This is CRITICAL - wrong app type = wrong UI theme

      final appWidget = AdaptiveAppFactory.createApp(
        title: 'Test App',
        home: const Scaffold(body: Text('Test')),
      );

      expect(appWidget, isA<MaterialApp>());
    });

    test('should detect current platform theme', () {
      // 🔹 Test that platform detection works correctly
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

    testWidgets('should create app with routes', (tester) async {
      // 🔹 Test that routes can be configured
      final routes = <String, WidgetBuilder>{
        '/settings': (context) => const Scaffold(body: Text('Settings')),
      };

      final appWidget = AdaptiveAppFactory.createApp(
        title: 'Test App',
        home: const Scaffold(body: Text('Home')),
        routes: routes,
      );

      expect(appWidget, isA<MaterialApp>());

      await tester.pumpWidget(appWidget);
      await tester.pumpAndSettle();

      // Verify the home widget was created
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('App Strategy Tests', () {
    test('should create material app strategy for material theme', () {
      // 🔹 Test that correct strategy is selected
      final strategy = AppStrategyFactory.getStrategy(PlatformTheme.material);
      expect(strategy, isA<MaterialAppStrategy>());
    });

    test('should create cupertino app strategy for cupertino theme', () {
      // 🔹 Test that correct strategy is selected
      final strategy = AppStrategyFactory.getStrategy(PlatformTheme.cupertino);
      expect(strategy, isA<CupertinoAppStrategy>());
    });

    test('should create material app strategy for web theme', () {
      // 🔹 Test that web theme uses material strategy
      final strategy = AppStrategyFactory.getStrategy(PlatformTheme.web);
      expect(strategy, isA<MaterialAppStrategy>());
    });
  });
}
