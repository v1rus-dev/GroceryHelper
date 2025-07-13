# Архитектура базы данных

## Обзор

Проект использует гибридную архитектуру базы данных, которая автоматически переключается между локальной SQLite базой данных и удаленной Firestore в зависимости от статуса авторизации пользователя.

## Структура

### Domain Layer (Слой домена)

```
lib/domain/
├── entities/
│   ├── product_item.dart      # Модель продукта
│   ├── product_type.dart      # Модель типа продукта
│   └── tag.dart              # Модель тега
├── repositories/
│   ├── products_repository.dart
│   └── tags_repository.dart
└── enums/
    ├── product_category.dart
    └── product_type.dart
```

### Infrastructure Layer (Слой инфраструктуры)

```
lib/infrastructure/
├── database/
│   ├── app_database.dart      # SQLite база данных (Drift)
│   ├── tables/               # Таблицы SQLite
│   ├── converters/           # Конвертеры для Drift
│   └── repositories/         # Реализации repository
├── datasources/
│   ├── interfaces/           # Интерфейсы datasource
│   ├── local/               # Локальные datasource (SQLite)
│   ├── network/             # Сетевые datasource (Firestore)
│   └── datasource_factory.dart
└── services/
    └── auth_status_service.dart
```

## Принцип работы

### 1. Автоматическое переключение

Repository автоматически выбирает правильный datasource на основе статуса авторизации:

```dart
ProductDatasourceInterface get _productDatasource {
  return _authStatusService.getCurrentUser() != null
      ? _networkProductDatasource
      : _localProductDatasource;
}
```

### 2. Единый интерфейс

Все datasource реализуют одинаковые интерфейсы, что обеспечивает прозрачное переключение:

```dart
abstract class ProductDatasourceInterface {
  Future<Either<AppError, List<ProductItem>>> getAllProducts();
  Future<Either<AppError, ProductItem?>> getProductById(int id);
  Future<Either<AppError, ProductItem>> createProduct(ProductItem product);
  // ...
}
```

### 3. Domain модели

Все операции работают с domain моделями, которые не зависят от конкретной реализации базы данных:

```dart
class ProductItem extends Equatable {
  final int id;
  final String name;
  final ProductCategory category;
  final int productTypeId;
  final DateTime createdAt;
  final String? itemId;
  final List<String> tags;
  // ...
}
```

## Использование

### Регистрация зависимостей

```dart
// Создание фабрики
final datasourceFactory = DatasourceFactory(database: appDatabase);

// Регистрация datasource
getIt.registerLazySingleton<ProductDatasourceInterface>(
  () => datasourceFactory.createLocalProductDatasource(),
  instanceName: 'local',
);

getIt.registerLazySingleton<ProductDatasourceInterface>(
  () => datasourceFactory.createNetworkProductDatasource(),
  instanceName: 'network',
);

// Регистрация repository
getIt.registerLazySingleton<ProductsRepository>(
  () => ProductsRepositoryImpl(
    localProductDatasource: getIt<ProductDatasourceInterface>(instanceName: 'local'),
    networkProductDatasource: getIt<ProductDatasourceInterface>(instanceName: 'network'),
    localProductTypeDatasource: getIt<ProductTypeDatasourceInterface>(instanceName: 'local'),
    networkProductTypeDatasource: getIt<ProductTypeDatasourceInterface>(instanceName: 'network'),
    authStatusService: getIt<AuthStatusService>(),
  ),
);
```

### Использование в BLoC

```dart
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository _repository;

  ProductsBloc({required ProductsRepository repository}) 
      : _repository = repository,
        super(ProductsInitial()) {
    
    on<LoadProducts>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    
    final result = await _repository.getAllProducts();
    
    result.fold(
      (error) => emit(ProductsError(error.message)),
      (products) => emit(ProductsLoaded(products)),
    );
  }
}
```

## Преимущества

1. **Прозрачность**: Приложение не знает, какая база данных используется
2. **Гибкость**: Легко добавить новые источники данных
3. **Тестируемость**: Можно легко мокать datasource для тестов
4. **Офлайн поддержка**: Автоматическое переключение на локальную БД
5. **Синхронизация**: Возможность синхронизации данных между локальной и удаленной БД

## Планы развития

1. **Синхронизация данных**: Реализация синхронизации между локальной и удаленной БД
2. **Кэширование**: Добавление кэширования для улучшения производительности
3. **Конфликт-резолюшн**: Обработка конфликтов при синхронизации
4. **Очередь операций**: Очередь операций для офлайн режима 