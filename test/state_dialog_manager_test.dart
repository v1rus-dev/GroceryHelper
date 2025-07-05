import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/common_ui/dialogs/state_dialog_manager.dart';

void main() {
  group('StateDialogManager', () {
    late StateDialogManager dialogManager;

    setUp(() {
      dialogManager = StateDialogManager();
    });

    tearDown(() {
      dialogManager.dispose();
    });

    test('should create instance', () {
      expect(dialogManager, isNotNull);
    });

    test('should dispose without errors', () {
      expect(() => dialogManager.dispose(), returnsNormally);
    });

    test('should handle multiple dispose calls', () {
      dialogManager.dispose();
      expect(() => dialogManager.dispose(), returnsNormally);
    });

    testWidgets('should show loading dialog', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold()));

      dialogManager.showLoading(text: 'Loading...');

      await tester.pump();

      expect(find.text('Loading...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should replace loading dialog with new one', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold()));

      // Показываем первый loading
      dialogManager.showLoading(text: 'Loading 1...');
      await tester.pump();

      // Показываем второй loading
      dialogManager.showLoading(text: 'Loading 2...');
      await tester.pump();

      // Проверяем что только второй loading виден
      expect(find.text('Loading 1...'), findsNothing);
      expect(find.text('Loading 2...'), findsOneWidget);
    });
  });
}
