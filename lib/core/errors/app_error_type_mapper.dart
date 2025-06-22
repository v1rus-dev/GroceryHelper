part of 'errors.dart';

void registerAppErrorHandler<T extends Object>(AppErrorHandler handler) {
  AppErrorHandlersRegistry.register<T>(handler);
}

AppError mapExceptionToAppError(
  Object e,
  StackTrace st, {
  String? customMessage,
  AppErrorType? customType,
}) {
  // Логируем ошибку через Talker
  TalkerService.error('Exception occurred', e, st);

  // Если оба параметра заданы явно, используем их без условий
  if (customMessage != null && customType != null) {
    return AppError(
      message: customMessage,
      type: customType,
      cause: e,
      stackTrace: st,
    );
  }

  // Если только customMessage, но не customType
  if (customMessage != null) {
    return AppError(
      message: customMessage,
      type: customType ?? AppErrorType.snackbar,
      cause: e,
      stackTrace: st,
    );
  }

  // Если только customType, но не customMessage
  if (customType != null) {
    return AppError(
      message: _defaultMessageForException(e),
      type: customType,
      cause: e,
      stackTrace: st,
    );
  }

  // Используем registry для поиска обработчика
  final handler = AppErrorHandlersRegistry.getHandler(e.runtimeType);
  if (handler != null) {
    return handler(e, st, customMessage: customMessage, customType: customType);
  }

  // Дефолтная логика
  return AppError(
    message: _defaultMessageForException(e),
    type: AppErrorType.snackbar,
    cause: e,
    stackTrace: st,
  );
}

String _defaultMessageForException(Object e) {
  if (e is SocketException) return "Нет подключения к интернету";
  if (e is TimeoutException) return "Сервер не отвечает";
  return "Неизвестная ошибка";
}
