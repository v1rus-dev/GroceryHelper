import 'package:flutter/material.dart';
import 'package:groceryhelper/core/services/global_context_service.dart';

typedef CloseDialog = Future<void> Function();

CloseDialog showLoadingDialog({required String text}) {
  final context = GlobalContextService.instance.navigatorKey.currentContext;

  if (context == null) return () async {};

  // Показ диалога через root navigator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [const CircularProgressIndicator(), const SizedBox(height: 10), Text(text)],
      ),
    ),
  );

  return () async {
    await Future.microtask(() {
      try {
        final navigator = GlobalContextService.instance.navigatorKey.currentState;
        if (navigator?.canPop() == true) {
          navigator!.pop();
        } else {}
      } catch (e, stack) {
        // Игнорируем ошибки при закрытии диалога (например, если контекст уже уничтожен)
      }
    });
  };
}
