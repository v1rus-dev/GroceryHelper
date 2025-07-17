import 'package:design/dialogs/generic_dialog.dart';
import 'package:design/dialogs/loading_dialog.dart';
import 'package:design/dialogs/success_dialog.dart';
import 'package:design/dialogs/error_dialog.dart';
import 'package:design/services/global_context_service.dart';

/// Менеджер для управления диалогами состояний
/// Предотвращает наложение диалогов друг на друга
class StateDialogManager {
  static final StateDialogManager instance = StateDialogManager._internal();
  StateDialogManager._internal();
  factory StateDialogManager() => instance;

  CloseDialog? _currentLoadingDialog;

  /// Показывает loading диалог, закрывая предыдущий если он был открыт
  Future<void> showLoading({String? text}) async {
    await _closeCurrentLoading();
    _currentLoadingDialog = showLoadingDialog(text: text);
  }

  Future<T?> showConfirmDialog<T>(
    String message, {
    String title = 'Success',
    required DialogOptionBuilder<T> optionsBuilder,
  }) async {
    final context = GlobalContextService.instance.context;
    if (context == null) return null;
    await _closeCurrentLoading();

    if (context.mounted) {
      return await showGenericDialog<T>(
        context: context,
        title: title,
        message: message,
        optionsBuilder: optionsBuilder,
      );
    }
    return null;
  }

  /// Показывает success диалог, закрывая loading диалог
  Future<void> showSuccess(String message, {String title = 'Success'}) async {
    final context = GlobalContextService.instance.context;

    if (context == null) return;

    _closeCurrentLoading();

    // Проверяем что контекст все еще валиден
    if (context.mounted) {
      await showSuccessDialog(context, message, title: title);
    }
  }

  /// Показывает error диалог, закрывая loading диалог
  Future<void> showError(String message) async {
    final context = GlobalContextService.instance.context;

    if (context == null) return;

    await _closeCurrentLoading();

    // Проверяем что контекст все еще валиден
    if (context.mounted) {
      await showErrorDialog(context, message);
    }
  }

  /// Закрывает текущий loading диалог
  Future<void> _closeCurrentLoading() async {
    if (_currentLoadingDialog != null) {
      try {
        await _currentLoadingDialog!();
      } catch (e) {
        // Игнорируем ошибки при закрытии диалога (например, если контекст уже уничтожен)
      }
      _currentLoadingDialog = null;
    }
  }

  /// Очищает все диалоги (вызывать при dispose виджета)
  Future<void> dispose() async {
    await _closeCurrentLoading();
  }
}
