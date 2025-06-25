import 'package:flutter/foundation.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/core/services/error_display_service.dart';
import 'package:groceryhelper/core/services/locator.dart';

/// Глобальный хелпер для обработки ошибок
class ErrorHandler {
  static ErrorDisplayService get _errorService => locator<ErrorDisplayService>();

  /// Обработать ошибку и показать пользователю
  static Future<void> handle(
    Object error,
    StackTrace stackTrace, {
    String? customMessage,
    AppErrorType? customType,
    VoidCallback? onRetry,
  }) async {
    await _errorService.handleError(
      error,
      stackTrace,
      customMessage: customMessage,
      customType: customType,
      onRetry: onRetry,
    );
  }

  /// Показать кастомную ошибку
  static Future<void> showError({
    required String message,
    AppErrorType type = AppErrorType.dialog,
    VoidCallback? onRetry,
  }) async {
    await _errorService.showCustomError(
      message: message,
      type: type,
      onRetry: onRetry,
    );
  }

  /// Показать сообщение об успехе
  static Future<void> showSuccess({
    required String message,
    String title = 'Успешно',
  }) async {
    await _errorService.showSuccess(
      message: message,
      title: title,
    );
  }

  /// Обработчик для Bloc/Cubit ошибок
  static void handleBlocError(Object error, StackTrace stackTrace) {
    handle(error, stackTrace, customType: AppErrorType.snackbar);
  }

  /// Обработчик для критических ошибок (показывает диалог)
  static void handleCriticalError(Object error, StackTrace stackTrace, {String? message}) {
    handle(error, stackTrace, customMessage: message, customType: AppErrorType.dialog);
  }

  /// Обработчик для сетевых ошибок
  static void handleNetworkError(Object error, StackTrace stackTrace, {VoidCallback? onRetry}) {
    handle(error, stackTrace, customType: AppErrorType.dialog, onRetry: onRetry);
  }

  /// Обработчик для silent ошибок (только логирование)
  static void handleSilentError(Object error, StackTrace stackTrace) {
    handle(error, stackTrace, customType: AppErrorType.silent);
  }
}
