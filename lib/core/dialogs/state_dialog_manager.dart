import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/loading_dialog.dart';
import 'package:groceryhelper/core/dialogs/success_dialog.dart';
import 'package:groceryhelper/core/dialogs/error_dialog.dart';

/// Менеджер для управления диалогами состояний
/// Предотвращает наложение диалогов друг на друга
class StateDialogManager {
  CloseDialog? _currentLoadingDialog;

  /// Показывает loading диалог, закрывая предыдущий если он был открыт
  void showLoading(BuildContext context, String text) {
    _closeCurrentLoading();
    _currentLoadingDialog = showLoadingDialog(context: context, text: text);
  }

  /// Показывает success диалог, закрывая loading диалог
  Future<void> showSuccess(BuildContext context, String message, {String title = 'Success'}) async {
    _closeCurrentLoading();

    // Проверяем что контекст все еще валиден
    if (context.mounted) {
      await showSuccessDialog(context, message, title: title);
    }
  }

  /// Показывает error диалог, закрывая loading диалог
  Future<void> showError(BuildContext context, String message) async {
    _closeCurrentLoading();

    // Проверяем что контекст все еще валиден
    if (context.mounted) {
      await showErrorDialog(context, message);
    }
  }

  /// Закрывает текущий loading диалог
  void _closeCurrentLoading() {
    if (_currentLoadingDialog != null) {
      try {
        _currentLoadingDialog!();
      } catch (e) {
        // Игнорируем ошибки при закрытии диалога (например, если контекст уже уничтожен)
      }
      _currentLoadingDialog = null;
    }
  }

  /// Очищает все диалоги (вызывать при dispose виджета)
  void dispose() {
    _closeCurrentLoading();
  }
}
