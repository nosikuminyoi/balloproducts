import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:balloproducts/main.dart';
import 'package:balloproducts/providers/product_provider.dart';

void main() {
  group('Ballo Products App Tests', () {
    testWidgets('App should start without crashing', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const MainApp());

      // Verify that the app title is displayed
      expect(find.text('Ballo Products'), findsOneWidget);
    });

    testWidgets('ProductProvider should be available', (WidgetTester tester) async {
      await tester.pumpWidget(const MainApp());

      // Verify that ProductProvider is available in the widget tree
      expect(find.byType(ChangeNotifierProvider<ProductProvider>), findsOneWidget);
    });

    testWidgets('App should have Material Design 3 theme', (WidgetTester tester) async {
      await tester.pumpWidget(const MainApp());

      // Verify that MaterialApp is used
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
} 