part of 'package:groceryhelper/core/errors/errors.dart';

class GeneralErrorHandlers {
  static final Map<Type, AppErrorHandler> handlers = {
    Exception: (e, st, {customMessage, customType}) => AppError(
      message: customMessage ?? "Произошла ошибка: ${e.toString()}",
      type: customType ?? AppErrorType.snackbar,
      cause: e,
      stackTrace: st,
    ),
  };
}
