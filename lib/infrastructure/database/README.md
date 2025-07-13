# Инициализация базы данных

## Обзор

Система инициализации базы данных автоматически заполняет таблицы начальными данными при первом запуске приложения.

## Компоненты

### DatabaseInitializer

Основной класс для инициализации базы данных. Отвечает за:
- Проверку статуса инициализации
- Заполнение таблиц начальными данными
- Управление флагом инициализации

### DatabaseService

Сервис-обертка для работы с базой данных и инициализацией. Предоставляет:
- Доступ к экземпляру базы данных
- Методы для инициализации
- Интеграцию с GetIt для dependency injection

## Что инициализируется

### Типы продуктов (ProductTypesTable)

1. **Предопределенные типы продуктов** - все типы из enum `ProductType`
   - Свежие продукты, напитки, закуски и т.д.
   - Каждый тип привязан к соответствующей категории
   - Флаг `isCustom` установлен в `false`

2. **Базовые типы для категорий** - "Другое" для каждой категории
   - "Другое (Еда)", "Другое (Дом)" и т.д.
   - Позволяет пользователям добавлять продукты в категорию без конкретного типа
   - Флаг `isCustom` установлен в `false`

### Теги (TagsTable)

Начальные теги для маркировки продуктов:
- Срочно
- Важно
- Акция
- Новинка
- Органический
- Без глютена
- Веганский
- Без лактозы
- Для детей
- Для животных

## Использование

### Автоматическая инициализация

Инициализация происходит автоматически при запуске приложения в `main.dart`:

```dart
void main() async {
  // ... другие инициализации
  
  final database = AppDatabase();
  await initServiceLocator(database); // Включает инициализацию БД
  
  runApp(MyApp());
}
```

### Ручная инициализация

```dart
final databaseService = DatabaseService.instance;
await databaseService.initializeDatabase();
```

### Проверка статуса

```dart
final databaseService = DatabaseService.instance;
final isInitialized = await databaseService.isDatabaseInitialized();
```

### Переинициализация (для тестирования)

```dart
final databaseService = DatabaseService.instance;
await databaseService.reinitializeDatabase();
```

## Флаг инициализации

Система использует `SharedPreferences` для хранения флага инициализации:
- Ключ: `database_initialized`
- Тип: `bool`
- Значение: `true` после успешной инициализации

Это предотвращает повторную инициализацию при каждом запуске приложения.

## Тестирование

Для тестирования инициализации используйте:

```dart
// Сброс флага инициализации
await initializer.resetInitializationFlag();

// Проверка инициализации
await initializer.initializeIfNeeded();

// Проверка данных
final productTypes = await database.select(database.productTypesTable).get();
final tags = await database.select(database.tagsTable).get();
```

## Добавление новых данных

Для добавления новых типов продуктов или тегов:

1. Обновите соответствующие enum'ы (`ProductType`, `ProductCategory`)
2. Добавьте новые теги в массив `defaultTags` в `DatabaseInitializer`
3. Обновите тесты
4. При необходимости сбросьте флаг инициализации для существующих пользователей

## Миграции

При изменении схемы базы данных:

1. Увеличьте `schemaVersion` в `AppDatabase`
2. Добавьте логику миграции в `onUpgrade` метод
3. При необходимости обновите данные инициализации 