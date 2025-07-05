import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerService {
  static Talker? _instance;

  static Talker get instance {
    _instance ??= Talker(
      settings: TalkerSettings(
        maxHistoryItems: 100,
        useConsoleLogs: true,
        useHistory: true,
        enabled: true,
      ),
    );
    return _instance!;
  }

  static void init() {
    // Инициализация Talker
    instance;
  }

  static void dispose() {
    _instance = null;
  }

  // Методы для удобного логирования
  static void log(String message) {
    instance.log(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    instance.error(message, error, stackTrace);
  }

  static void warning(String message) {
    instance.warning(message);
  }

  static void debug(String message) {
    instance.debug(message);
  }

  static void verbose(String message) {
    instance.verbose(message);
  }
}
