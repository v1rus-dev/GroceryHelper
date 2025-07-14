part of '../errors.dart';

class FirebaseErrorHandlers {
  static final Map<Type, AppErrorHandler> handlers = {
    FirebaseAuthException: (e, st, {customMessage, customType}) {
      final authException = e as FirebaseAuthException;
      String message;
      AppErrorType type;

      switch (authException.code) {
        case 'user-not-found':
          message = "Пользователь не найден";
          type = AppErrorType.dialog;
          break;
        case 'wrong-password':
          message = "Неверный пароль";
          type = AppErrorType.snackbar;
          break;
        case 'email-already-in-use':
          message = "Этот email уже используется";
          type = AppErrorType.dialog;
          break;
        case 'weak-password':
          message = "Пароль слишком слабый";
          type = AppErrorType.snackbar;
          break;
        case 'invalid-email':
          message = "Неверный формат email";
          type = AppErrorType.snackbar;
          break;
        case 'user-disabled':
          message = "Аккаунт заблокирован";
          type = AppErrorType.dialog;
          break;
        case 'too-many-requests':
          message = "Слишком много попыток. Попробуйте позже";
          type = AppErrorType.dialog;
          break;
        case 'operation-not-allowed':
          message = "Операция не разрешена";
          type = AppErrorType.dialog;
          break;
        case 'network-request-failed':
          message = "Ошибка сети";
          type = AppErrorType.snackbar;
          break;
        case 'popup-closed-by-user':
          message = "Вход отменен пользователем";
          type = AppErrorType.silent;
          break;
        case 'popup-blocked':
          message = "Всплывающее окно заблокировано браузером";
          type = AppErrorType.dialog;
          break;
        default:
          message = "Ошибка аутентификации: ${authException.message ?? 'Неизвестная ошибка'}";
          type = AppErrorType.dialog;
      }

      return AppError(message: customMessage ?? message, type: customType ?? type, cause: e, stackTrace: st);
    },
    FirebaseException: (e, st, {customMessage, customType}) {
      final firebaseException = e as FirebaseException;
      String message;

      switch (firebaseException.code) {
        case 'permission-denied':
          message = "Доступ запрещен";
          break;
        case 'unavailable':
          message = "Сервис временно недоступен";
          break;
        case 'deadline-exceeded':
          message = "Превышено время ожидания";
          break;
        case 'resource-exhausted':
          message = "Превышен лимит запросов";
          break;
        case 'failed-precondition':
          message = "Операция не может быть выполнена";
          break;
        case 'aborted':
          message = "Операция была прервана";
          break;
        case 'out-of-range':
          message = "Выход за пределы допустимого диапазона";
          break;
        case 'unimplemented':
          message = "Функция не реализована";
          break;
        case 'internal':
          message = "Внутренняя ошибка сервера";
          break;
        case 'data-loss':
          message = "Потеря данных";
          break;
        case 'unauthenticated':
          message = "Требуется аутентификация";
          break;
        default:
          message = "Ошибка Firebase: ${firebaseException.message ?? 'Неизвестная ошибка'}";
      }

      return AppError(
        message: customMessage ?? message,
        type: customType ?? AppErrorType.dialog,
        cause: e,
        stackTrace: st,
      );
    },
  };
}
