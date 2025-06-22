import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

part 'app_error.dart';
part 'app_error_type.dart';
part 'app_error_type_mapper.dart';
part 'app_error_handlers_registry.dart';
part 'handlers/network_error_handlers.dart';
part 'handlers/firebase_error_handlers.dart';
part 'handlers/general_error_handlers.dart';

// Экспортируем тип AppErrorHandler для использования в других файлах
typedef AppErrorHandler =
    AppError Function(
      Object e,
      StackTrace st, {
      String? customMessage,
      AppErrorType? customType,
    });
