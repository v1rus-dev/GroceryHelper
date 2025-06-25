import 'dart:io';
import 'dart:async';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/core/utils/error_handler.dart';

/// Примеры использования интегрированной системы обработки ошибок
class ErrorHandlerExample {
  
  /// Пример обработки сетевой ошибки
  static Future<void> networkRequestExample() async {
    try {
      // Симуляция сетевого запроса
      throw SocketException('No internet connection');
    } catch (error, stackTrace) {
      // Система автоматически определит тип ошибки и покажет соответствующий UI
      await ErrorHandler.handleNetworkError(
        error, 
        stackTrace,
        onRetry: () => networkRequestExample(), // Retry callback
      );
    }
  }

  /// Пример обработки ошибки таймаута
  static Future<void> timeoutExample() async {
    try {
      // Симуляция таймаута
      throw TimeoutException('Request timeout', const Duration(seconds: 30));
    } catch (error, stackTrace) {
      // Покажет диалог с ошибкой таймаута
      await ErrorHandler.handle(error, stackTrace);
    }
  }

  /// Пример обработки Firebase ошибки
  static Future<void> firebaseAuthExample() async {
    try {
      // Симуляция ошибки Firebase
      throw Exception('firebase-auth-error: invalid-credential');
    } catch (error, stackTrace) {
      // Система определит Firebase ошибку и покажет соответствующий заголовок
      await ErrorHandler.handleCriticalError(error, stackTrace);
    }
  }

  /// Пример показа кастомной ошибки
  static Future<void> customErrorExample() async {
    await ErrorHandler.showError(
      message: 'Это кастомная ошибка',
      type: AppErrorType.snackbar,
    );
  }

  /// Пример показа успешного сообщения
  static Future<void> successExample() async {
    await ErrorHandler.showSuccess(
      title: 'Готово!',
      message: 'Операция выполнена успешно',
    );
  }

  /// Пример silent ошибки (только логирование)
  static void silentErrorExample() {
    try {
      throw Exception('This is a silent error');
    } catch (error, stackTrace) {
      // Только залогирует ошибку, не покажет пользователю
      ErrorHandler.handleSilentError(error, stackTrace);
    }
  }

  /// Пример использования в Bloc
  static void blocErrorExample() {
    try {
      throw Exception('Bloc error');
    } catch (error, stackTrace) {
      // Покажет snackbar с ошибкой
      ErrorHandler.handleBlocError(error, stackTrace);
    }
  }
}
