import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/database/database_initializer.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DatabaseInitializer Tests', () {
    late AppDatabase database;
    late DatabaseInitializer initializer;

    setUp(() async {
      // Создаем in-memory базу данных для тестов
      database = AppDatabase();
      initializer = DatabaseInitializer(database);

      // Сбрасываем флаг инициализации
      await initializer.resetInitializationFlag();
    });

    tearDown(() async {
      await database.close();
    });

    test('should initialize database on first run', () async {
      // Arrange
      final isInitializedBefore = await initializer.isInitialized();

      // Act
      await initializer.initializeIfNeeded();
      final isInitializedAfter = await initializer.isInitialized();

      // Assert
      expect(isInitializedBefore, false);
      expect(isInitializedAfter, true);
    });

    test('should not reinitialize if already initialized', () async {
      // Arrange
      await initializer.initializeIfNeeded();
      final productTypesBefore = await database.select(database.productTypesTable).get();

      // Act
      await initializer.initializeIfNeeded();
      final productTypesAfter = await database.select(database.productTypesTable).get();

      // Assert
      expect(productTypesBefore.length, productTypesAfter.length);
    });

    test('should populate product types table with predefined types', () async {
      // Act
      await initializer.initializeIfNeeded();
      final productTypes = await database.select(database.productTypesTable).get();

      // Assert
      expect(productTypes.isNotEmpty, true);

      // Проверяем, что все предопределенные типы продуктов добавлены
      final predefinedTypes = ProductTypeUtils.allTypes;
      expect(productTypes.length, greaterThan(predefinedTypes.length));

      // Проверяем наличие некоторых конкретных типов
      final freshProduceType = productTypes.firstWhere((type) => type.name == ProductType.freshProduce.displayName);
      expect(freshProduceType.productCategory, ProductCategory.food);
      expect(freshProduceType.isCustom, false);
    });

    test('should populate tags table with default tags', () async {
      // Act
      await initializer.initializeIfNeeded();
      final tags = await database.select(database.tagsTable).get();

      // Assert
      expect(tags.isNotEmpty, true);

      // Проверяем наличие некоторых конкретных тегов
      final tagNames = tags.map((tag) => tag.name).toList();
      expect(tagNames, contains('Срочно'));
      expect(tagNames, contains('Важно'));
      expect(tagNames, contains('Акция'));
    });

    test('should add "other" types for each category', () async {
      // Act
      await initializer.initializeIfNeeded();
      final productTypes = await database.select(database.productTypesTable).get();

      // Assert
      for (final category in ProductCategory.values) {
        if (category != ProductCategory.other) {
          final otherType = productTypes.firstWhere((type) => type.name == 'Другое (${category.displayName})');
          expect(otherType.productCategory, category);
          expect(otherType.isCustom, false);
        }
      }
    });

    test('should reinitialize database when called', () async {
      // Arrange
      await initializer.initializeIfNeeded();
      final productTypesBefore = await database.select(database.productTypesTable).get();

      // Act
      await initializer.reinitialize();
      final productTypesAfter = await database.select(database.productTypesTable).get();

      // Assert
      expect(productTypesBefore.length, productTypesAfter.length);
      expect(await initializer.isInitialized(), true);
    });
  });
}
