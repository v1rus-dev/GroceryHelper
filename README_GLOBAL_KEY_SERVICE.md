# GlobalKeyService

`GlobalKeyService` - это централизованный сервис для управления глобальными ключами в приложении. Он обеспечивает единую точку доступа к важным глобальным ключам, таким как `NavigatorKey`.

## Особенности

- **Singleton паттерн** - единый экземпляр сервиса
- **Централизованное управление** - все глобальные ключи в одном месте
- **Типобезопасность** - строгая типизация для всех ключей
- **Простота использования** - простой API для доступа к ключам

## Основные возможности

### NavigatorKey

```dart
// Получить navigatorKey
GlobalKey<NavigatorState> navigatorKey = GlobalKeyService.instance.navigatorKey;

// Получить текущий контекст
BuildContext? context = GlobalKeyService.instance.context;

// Проверить доступность контекста
bool hasContext = GlobalKeyService.instance.hasContext;
```

## Настройка в main.dart

Сервис автоматически инициализируется в `main.dart`:

```dart
return MaterialApp.router(
  routerConfig: appRouter,
  builder: (context, child) {
    return Navigator(
      key: GlobalKeyService.instance.navigatorKey,
      // ... остальные настройки
    );
  },
);
```

## Регистрация в DI

Сервис зарегистрирован в `locator.dart` как singleton:

```dart
Future<void> initServices() async {
  locator.registerSingleton(GlobalKeyService.instance);
  // ... другие сервисы
}
```

## Использование в сервисах

### DialogService

```dart
class DialogService {
  // Получить контекст из GlobalKeyService
  BuildContext? get context => GlobalKeyService.instance.context;
  
  // Получить navigatorKey из GlobalKeyService
  GlobalKey<NavigatorState> get navigatorKey => GlobalKeyService.instance.navigatorKey;
}
```

### SmoothDialogService

```dart
class SmoothDialogService {
  // Получить контекст из GlobalKeyService
  BuildContext? get context => GlobalKeyService.instance.context;
  
  // Получить navigatorKey из GlobalKeyService
  GlobalKey<NavigatorState> get navigatorKey => GlobalKeyService.instance.navigatorKey;
}
```

## Преимущества

1. **Единая точка управления** - все глобальные ключи в одном месте
2. **Упрощение архитектуры** - сервисы не создают собственные ключи
3. **Консистентность** - все сервисы используют одни и те же ключи
4. **Тестируемость** - легче мокать и тестировать
5. **Масштабируемость** - легко добавлять новые глобальные ключи

## Расширение функциональности

Для добавления новых глобальных ключей:

```dart
class GlobalKeyService {
  // Существующие ключи
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  
  // Новые ключи
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Геттеры
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  GlobalKey<FormState> get formKey => _formKey;
}
```

## Лучшие практики

1. **Всегда используйте GlobalKeyService** для доступа к глобальным ключам
2. **Не создавайте собственные navigatorKey** в сервисах
3. **Проверяйте доступность контекста** перед использованием
4. **Используйте hasContext** для проверки состояния
5. **Регистрируйте сервис в DI** для консистентности 