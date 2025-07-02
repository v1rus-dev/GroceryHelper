import 'package:flutter/material.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({required BuildContext context, required String text}) {
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [CircularProgressIndicator(), SizedBox(height: 10), Text(text)],
    ),
  );

  showDialog(context: context, barrierDismissible: false, builder: (context) => dialog);

  return () {
    try {
      TalkerService.log('LoadingDialog: Closing dialog');
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Игнорируем ошибки при закрытии диалога
    }
  };
}
