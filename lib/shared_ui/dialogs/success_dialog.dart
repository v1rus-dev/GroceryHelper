import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/dialogs/state_dialog_manager.dart';

/// Показывает диалог успеха с одной кнопкой "OK"
Future<void> showSuccessDialog(
  BuildContext context,
  String message, {
  String title = 'Success',
  String buttonText = 'OK',
}) async {
  await StateDialogManager().showConfirmDialog(message, title: title, optionsBuilder: () => {buttonText: null});
}

/// Показывает диалог успеха с двумя кнопками
Future<T?> showSuccessDialogWithTwoButtons<T>({
  required BuildContext context,
  required String message,
  String title = 'Success',
  required String primaryButtonText,
  required String secondaryButtonText,
  T? primaryButtonValue,
  T? secondaryButtonValue,
}) async {
  return await StateDialogManager().showConfirmDialog<T>(
    message,
    title: title,
    optionsBuilder: () => {secondaryButtonText: secondaryButtonValue, primaryButtonText: primaryButtonValue},
  );
}

/// Показывает диалог успеха с кастомными опциями
Future<T?> showSuccessDialogWithOptions<T>({
  required BuildContext context,
  required String message,
  String title = 'Success',
  required Map<String, T?> options,
}) async {
  return await StateDialogManager().showConfirmDialog<T>(message, title: title, optionsBuilder: () => options);
}
