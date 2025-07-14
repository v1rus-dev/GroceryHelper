part of 'errors.dart';

class AppErrorHandlersRegistry {
  static final Map<Type, AppErrorHandler> _handlers = {
    ...NetworkErrorHandlers.handlers,
    ...FirebaseErrorHandlers.handlers,
    ...GeneralErrorHandlers.handlers,
  };

  static void register<T extends Object>(AppErrorHandler handler) {
    _handlers[T] = handler;
  }

  static AppErrorHandler? getHandler(Type type) => _handlers[type];
}
