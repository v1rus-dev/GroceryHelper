# Решение проблемы с системными цветами

## Проблема
При использовании `SafeArea` перед `Scaffold` или без `Scaffold` статус бар и нижняя навигационная панель становятся черными.

## Причина
Flutter не может правильно определить цвета для системных элементов, когда `SafeArea` используется без правильного контекста темы.

## Решения

### 1. Использование AppScaffold (Рекомендуется)
Создан специальный виджет `AppScaffold`, который обеспечивает правильную структуру:

```dart
import 'package:groceryhelper/core/widgets/app_scaffold.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Заголовок')), // AppBar автоматически применяет настройки темы
      body: SafeArea(
        child: Column(
          children: [
            Text('Мой контент'),
          ],
        ),
      ),
    );
  }
}
```

### 2. Настройка в теме приложения
В файлах `app_theme.dart` и `app_theme_ios.dart` добавлены настройки `SystemUiOverlayStyle` в `appBarTheme`:

```dart
appBarTheme: AppBarTheme(
  systemOverlayStyle: SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ),
),
```

### 3. Настройка в MainActivity (Android)
В `MainActivity.kt` добавлены настройки для прозрачных системных панелей:

```kotlin
override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    
    WindowCompat.setDecorFitsSystemWindows(window, false)
    window.statusBarColor = android.graphics.Color.TRANSPARENT
    window.navigationBarColor = android.graphics.Color.TRANSPARENT
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS)
}
```

## Правильная структура экранов

### ❌ Неправильно
```dart
return SafeArea(
  child: Scaffold(
    body: Column(...),
  ),
);
```

### ✅ Правильно
```dart
return AppScaffold(
  appBar: AppBar(title: Text('Заголовок')), // AppBar применяет настройки темы
  body: SafeArea(
    child: Column(...),
  ),
);
```

или

```dart
return Scaffold(
  appBar: AppBar(title: Text('Заголовок')), // AppBar применяет настройки темы
  body: SafeArea(
    child: Column(...),
  ),
);
```

## Важно!
Настройки `SystemUiOverlayStyle` из `appBarTheme` применяются **только когда есть AppBar**. Если у вас экран без AppBar, системные цвета могут не применяться корректно.

## Обновленные экраны
Следующие экраны были обновлены для использования `AppScaffold`:
- `RegisterScreen`
- `UserUnauthenticatedScreen`

## Примечания
- `AppScaffold` обеспечивает правильную структуру и применение темы
- Системные панели становятся прозрачными и адаптируются к фону приложения
- Иконки в статус баре автоматически меняют цвет в зависимости от темы
- Для экранов без AppBar рекомендуется добавить AppBar или использовать альтернативные решения 