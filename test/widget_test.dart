// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/main.dart';
import 'package:card_snap_ui/core/di/service_locator.dart';

void main() {
  setUpAll(() async {
    await initializeDependencyInjection();
  });

  testWidgets('Card Snap Wallet app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CardSnapApp());

    // Wait for the app to initialize and load
    await tester.pumpAndSettle();

    // Verify that our app title is displayed.
    expect(find.text('Card Snap Wallet'), findsOneWidget);

    // Verify that the empty state is shown when no cards exist.
    expect(find.text('No cards yet'), findsOneWidget);
    expect(
      find.text('Add your first loyalty card by scanning a QR code or barcode'),
      findsOneWidget,
    );
  });
}
