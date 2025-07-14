part of 'errors.dart';

class AppError {
  final String message;
  final AppErrorType type;
  final Object? cause;
  final StackTrace? stackTrace;

  AppError({required this.message, required this.type, this.cause, this.stackTrace});
}
