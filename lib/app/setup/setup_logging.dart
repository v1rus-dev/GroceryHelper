import 'package:flutter/foundation.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

Future<void> setupLogging() async {
  // Инициализируем Talker
  if (kDebugMode) {
    TalkerService.init();
  }
}
