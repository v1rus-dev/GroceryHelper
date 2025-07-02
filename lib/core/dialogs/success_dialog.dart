import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/generic_dialog.dart';

/// Показывает диалог успеха с одной кнопкой "OK"
Future<void> showSuccessDialog(
  BuildContext context,
  String message, {
  String title = 'Success',
  String buttonText = 'OK',
}) {
  return showGenericDialog(context: context, title: title, message: message, optionsBuilder: () => {buttonText: null});
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
}) {
  return showGenericDialog<T>(
    context: context,
    title: title,
    message: message,
    optionsBuilder: () => {secondaryButtonText: secondaryButtonValue, primaryButtonText: primaryButtonValue},
  );
}

/// Показывает диалог успеха с кастомными опциями
Future<T?> showSuccessDialogWithOptions<T>({
  required BuildContext context,
  required String message,
  String title = 'Success',
  required Map<String, T?> options,
}) {
  return showGenericDialog<T>(context: context, title: title, message: message, optionsBuilder: () => options);
}
