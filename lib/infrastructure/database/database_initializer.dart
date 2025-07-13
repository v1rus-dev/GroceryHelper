import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/preferences/app_preferences.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';
import '../../domain/enums/product_type.dart';
import 'app_database.dart';

class DatabaseInitializer {
  static const String _isInitializedKey = 'database_initialized';

  final AppDatabase _database;

  DatabaseInitializer(this._database);

  /// Проверяет, была ли база данных уже инициализирована
  Future<bool> isInitialized() async {
    TalkerService.log('isInitialized: ${AppPreferences.getBool(_isInitializedKey)}');
    return AppPreferences.getBool(_isInitializedKey) ?? false;
  }

  /// Инициализирует базу данных начальными данными
  Future<void> initializeIfNeeded() async {
    TalkerService.log('initializeIfNeeded');
    if (await isInitialized()) {
      return;
    }

    await _initializeProductTypes();
    await _initializeDefaultTags();
    await _markAsInitialized();
  }

  /// Инициализирует таблицу типов продуктов
  Future<void> _initializeProductTypes() async {
    TalkerService.log('initializeProductTypes');
    final productTypesCompanion = <ProductTypesTableCompanion>[];

    // Добавляем все предопределенные типы продуктов
    for (final productType in ProductTypeUtils.allTypes) {
      productTypesCompanion.add(
        ProductTypesTableCompanion.insert(
          name: productType.displayName,
          productCategory: productType.category,
          productType: Value(productType),
          isCustom: const Value(false),
        ),
      );
    }

    await _database.batch((batch) {
      batch.insertAll(_database.productTypesTable, productTypesCompanion);
    });
  }

  /// Инициализирует таблицу тегов начальными тегами
  Future<void> _initializeDefaultTags() async {
    const defaultTags = [
      'Срочно',
      'Важно',
      'Акция',
      'Новинка',
      'Органический',
      'Без глютена',
      'Веганский',
      'Без лактозы',
      'Для детей',
      'Для животных',
    ];

    final tagsCompanion = defaultTags.map((tag) => TagsTableCompanion.insert(name: tag)).toList();

    await _database.batch((batch) {
      batch.insertAll(_database.tagsTable, tagsCompanion);
    });
  }

  /// Отмечает базу данных как инициализированную
  Future<void> _markAsInitialized() async {
    await AppPreferences.setBool(_isInitializedKey, true);
  }

  /// Сбрасывает флаг инициализации (для тестирования или переинициализации)
  Future<void> resetInitializationFlag() async {
    await AppPreferences.remove(_isInitializedKey);
  }

  /// Полная переинициализация базы данных (удаляет все данные и создает заново)
  Future<void> reinitialize() async {
    await _database.batch((batch) {
      batch.deleteAll(_database.productTypesTable);
      batch.deleteAll(_database.tagsTable);
      batch.deleteAll(_database.productItemsTable);
      batch.deleteAll(_database.productItemTagsTable);
    });
    await resetInitializationFlag();
    await initializeIfNeeded();
  }
}
