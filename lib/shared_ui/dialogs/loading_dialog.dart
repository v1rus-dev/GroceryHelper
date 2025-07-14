import 'package:flutter/material.dart';
import 'package:groceryhelper/infrastructure/services/global_context_service.dart';
import 'package:groceryhelper/shared_ui/theme/app_theme_extension.dart';

typedef CloseDialog = Future<void> Function();

class LoadingDialogView extends StatelessWidget {
  final String? text;

  const LoadingDialogView({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
          decoration: BoxDecoration(color: context.theme.background, borderRadius: BorderRadius.circular(16.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (text != null) ...[const SizedBox(height: 10), Text(text!)],
            ],
          ),
        ),
      ),
    );
  }
}

CloseDialog showLoadingDialog({String? text}) {
  final context = GlobalContextService.instance.navigatorKey.currentContext;

  if (context == null) return () async {};

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => LoadingDialogView(text: text),
  );

  return () async {
    await Future.microtask(() {
      try {
        final navigator = GlobalContextService.instance.navigatorKey.currentState;
        if (navigator?.canPop() == true) {
          navigator!.pop();
        }
      } catch (e) {
        // Игнорируем ошибки при закрытии диалога (например, если контекст уже уничтожен)
      }
    });
  };
}
