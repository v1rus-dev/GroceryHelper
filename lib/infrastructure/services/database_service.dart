import '../database/app_database.dart';
import '../database/database_initializer.dart';

class DatabaseService {
  late final AppDatabase _database;
  late final DatabaseInitializer _initializer;

  DatabaseService({required AppDatabase database}) {
    _database = database;
    _initializer = DatabaseInitializer(_database);
  }

  /// Получить экземпляр базы данных
  AppDatabase get database => _database;

  /// Получить инициализатор базы данных
  DatabaseInitializer get initializer => _initializer;

  /// Инициализировать базу данных при первом запуске
  Future<void> initializeDatabase() async {
    await _initializer.initializeIfNeeded();
  }

  /// Проверить, была ли база данных инициализирована
  Future<bool> isDatabaseInitialized() async {
    return await _initializer.isInitialized();
  }

  /// Переинициализировать базу данных (для тестирования или сброса)
  Future<void> reinitializeDatabase() async {
    await _initializer.reinitialize();
  }

  /// Закрыть соединение с базой данных
  Future<void> close() async {
    await _database.close();
  }
}
