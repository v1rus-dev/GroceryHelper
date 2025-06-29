import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/core/services/dialog_service.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

class ErrorDisplayService {
  static final ErrorDisplayService _instance = ErrorDisplayService._internal();
  factory ErrorDisplayService() => _instance;
  ErrorDisplayService._internal();

  static ErrorDisplayService get instance => _instance;

  final DialogService _dialogService = DialogService.instance;

  /// Обрабатывает и отображает ошибку согласно её типу
  Future<void> handleError(
    Object error,
    StackTrace stackTrace, {
    String? customMessage,
    AppErrorType? customType,
    VoidCallback? onRetry,
  }) async {
    // Получаем обработчик для данного типа ошибки
    final handler = AppErrorHandlersRegistry.getHandler(error.runtimeType);

    AppError appError;
    if (handler != null) {
      // Используем зарегистрированный обработчик
      appError = handler(error, stackTrace, customMessage: customMessage, customType: customType);
    } else {
      // Используем базовый обработчик
      appError = AppError(
        message: customMessage ?? 'Произошла неизвестная ошибка: ${error.toString()}',
        type: customType ?? AppErrorType.dialog,
        cause: error,
        stackTrace: stackTrace,
      );
    }

    // Логируем ошибку
    TalkerService.error('Error handled by ErrorDisplayService: ${appError.message}', error, stackTrace);

    // Отображаем ошибку согласно её типу
    await _displayError(appError, onRetry: onRetry);
  }

  /// Отображает ошибку согласно её типу
  Future<void> _displayError(AppError appError, {VoidCallback? onRetry}) async {
    switch (appError.type) {
      case AppErrorType.dialog:
        await _showErrorDialog(appError, onRetry: onRetry);
        break;
      case AppErrorType.snackbar:
        _showErrorSnackbar(appError);
        break;
      case AppErrorType.inline:
        // Inline ошибки обрабатываются на уровне UI компонентов
        TalkerService.warning('Inline error should be handled by UI component: ${appError.message}');
        break;
      case AppErrorType.silent:
        // Silent ошибки только логируются
        TalkerService.error('Silent error: ${appError.message}');
        break;
    }
  }

  /// Показывает диалог с ошибкой
  Future<void> _showErrorDialog(AppError appError, {VoidCallback? onRetry}) async {
    await _dialogService.showErrorDialog(title: _getErrorTitle(appError), message: appError.message, onRetry: onRetry);
  }

  /// Показывает снекбар с ошибкой
  void _showErrorSnackbar(AppError appError) {
    final context = _dialogService.navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(appError.message, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  /// Получает заголовок для ошибки в зависимости от её причины
  String _getErrorTitle(AppError appError) {
    final cause = appError.cause;

    if (cause is SocketException) {
      return 'Ошибка сети';
    } else if (cause is TimeoutException) {
      return 'Превышено время ожидания';
    } else if (cause is FormatException) {
      return 'Ошибка данных';
    } else if (cause.toString().contains('firebase') || cause.toString().toLowerCase().contains('auth')) {
      return 'Ошибка авторизации';
    }

    return 'Ошибка приложения';
  }

  /// Показать кастомную ошибку напрямую
  Future<void> showCustomError({
    required String message,
    AppErrorType type = AppErrorType.dialog,
    VoidCallback? onRetry,
  }) async {
    final appError = AppError(message: message, type: type);

    await _displayError(appError, onRetry: onRetry);
  }

  /// Показать успешное сообщение
  Future<void> showSuccess({required String message, String title = 'Успешно'}) async {
    _dialogService.showInfoDialog(title: title, message: message, buttonText: 'OK');
  }
}
