part of 'package:cookmatch/core/errors/errors.dart';

class NetworkErrorHandlers {
  static final Map<Type, AppErrorHandler> handlers = {
    SocketException: (e, st, {customMessage, customType}) => AppError(
      message: customMessage ?? "Нет подключения к интернету",
      type: customType ?? AppErrorType.dialog,
      cause: e,
      stackTrace: st,
    ),
    TimeoutException: (e, st, {customMessage, customType}) => AppError(
      message: customMessage ?? "Сервер не отвечает",
      type: customType ?? AppErrorType.snackbar,
      cause: e,
      stackTrace: st,
    ),
  };
}
