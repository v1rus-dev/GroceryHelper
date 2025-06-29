import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/core/services/dialog_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DialogService Tests', () {
    late DialogService dialogService;

    setUp(() {
      dialogService = DialogService.instance;
    });

    test('should be singleton', () {
      final instance1 = DialogService.instance;
      final instance2 = DialogService.instance;
      expect(identical(instance1, instance2), isTrue);
    });

    test('should have navigatorKey', () {
      expect(dialogService.navigatorKey, isNotNull);
    });

    test('should have null context initially', () {
      expect(dialogService.context, isNull);
    });

    test('should track dialog state correctly', () {
      expect(dialogService.isDialogShowing, isFalse);
      expect(dialogService.currentDialog, isNull);
    });
  });
}

class TestContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
