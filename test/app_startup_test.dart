import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:card_snap_ui/main.dart';

void main() {
  testWidgets('Card Snap Wallet app startup test', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const CardSnapApp());
    
    // Wait for initialization to complete
    await tester.pumpAndSettle();
    
    // Verify the app title is displayed
    expect(find.text('Card Snap Wallet'), findsOneWidget);
    
    // Verify the app doesn't crash and shows the main content
    expect(find.text('No cards yet'), findsOneWidget);
    
    // Verify the add button is present
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });
  
  testWidgets('Card Snap Wallet app handles empty state', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const CardSnapApp());
    
    // Wait for initialization
    await tester.pumpAndSettle();
    
    // Verify empty state message
    expect(find.text('No cards yet'), findsOneWidget);
    expect(find.text('Add your first loyalty card by scanning a QR code or barcode'), findsOneWidget);
    
    // Verify the app is stable (no crashes)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
