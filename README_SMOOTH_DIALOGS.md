# Smooth Dialogs

Система плавных диалогов с анимацией изменения размеров и контента.

## Особенности

- **Плавная анимация размеров**: Диалоги изменяют размеры одновременно во все стороны
- **Отложенное обновление контента**: Новый контент показывается только после завершения анимации размеров
- **Типизированные диалоги**: Каждый тип диалога имеет свои параметры и размеры
- **Централизованное управление**: Единый сервис для показа и обновления диалогов
- **Предотвращение overflow**: Контент правильно обрезается и адаптируется под размеры диалога

## Архитектура

### BaseSmoothDialog
Базовый виджет для всех smooth диалогов. Обеспечивает:
- Плавную анимацию изменения размеров
- Отложенное обновление контента
- Правильное центрирование и ограничения размеров
- Предотвращение overflow

### SmoothDialog
Абстрактный класс для определения диалогов:
```dart
abstract class SmoothDialog {
  Widget buildContent(BuildContext context);
  double get width;
  double get height;
  double get borderRadius;
}
```

### SmoothDialogService
Сервис для управления диалогами:
```dart
class SmoothDialogService {
  // Показать диалог
  Future<dynamic> showCustomDialog(SmoothDialog dialog);
  
  // Обновить текущий диалог
  Future<dynamic> updateDialog(SmoothDialog newDialog);
  
  // Закрыть диалог
  void closeDialog();
}
```

## Доступные диалоги

### SmoothLoadingDialog
Диалог загрузки с индикатором прогресса.

```dart
// Обычный диалог загрузки (200x80)
SmoothLoadingDialog()

// Диалог загрузки с текстом (200x120)
SmoothLoadingDialog(text: 'Загрузка...')

// Маленький диалог загрузки (80x80)
SmoothLoadingDialog.small()
```

### SmoothDialogConfirm
Диалог подтверждения с кнопками.

```dart
SmoothDialogConfirm(
  title: 'Заголовок',
  message: 'Сообщение',
  confirmButtonText: 'Подтвердить',
  cancelButtonText: 'Отмена',
)
```

## Использование

### Базовое использование

```dart
final smoothDialogService = locator<SmoothDialogService>();

// Показать диалог
smoothDialogService.showCustomDialog(
  SmoothLoadingDialog(text: 'Загрузка...'),
);

// Обновить диалог
smoothDialogService.updateDialog(
  SmoothDialogConfirm(
    title: 'Готово!',
    message: 'Операция завершена',
    confirmButtonText: 'OK',
  ),
);

// Закрыть диалог
smoothDialogService.closeDialog();
```

### Пример с изменением размеров

```dart
// Показываем маленький диалог
smoothDialogService.showCustomDialog(
  SmoothLoadingDialog.small(),
);

// Через 2 секунды изменяем на большой
Future.delayed(const Duration(seconds: 2), () {
  smoothDialogService.updateDialog(
    SmoothLoadingDialog(text: 'Большой диалог'),
  );
});
```

### Пример с обновлением контента

```dart
// Показываем диалог загрузки
smoothDialogService.showCustomDialog(
  SmoothLoadingDialog(text: 'Начинаем...'),
);

// Обновляем сообщение каждую секунду
Timer.periodic(const Duration(seconds: 1), (timer) {
  step++;
  if (step > 5) {
    timer.cancel();
    smoothDialogService.closeDialog();
    return;
  }
  
  smoothDialogService.updateDialog(
    SmoothLoadingDialog(text: 'Шаг $step из 5...'),
  );
});
```

## Анимация обновления

При обновлении диалога происходит следующая последовательность:

1. **Скрытие контента** (150ms) - текущий контент плавно исчезает
2. **Изменение размеров** (300ms) - диалог изменяет размеры одновременно во все стороны
3. **Показ нового контента** (150ms) - новый контент плавно появляется

Это предотвращает проблемы с overflow и обеспечивает плавную анимацию.

## Размеры диалогов

### SmoothLoadingDialog
- **Обычный**: 200x80 пикселей
- **С текстом**: 200x120 пикселей  
- **Маленький**: 80x80 пикселей

### SmoothDialogConfirm
- **Автоматический**: адаптируется под контент с минимальными размерами
- **Максимальная ширина**: 300 пикселей
- **Максимальная высота**: 400 пикселей

## Предотвращение overflow

Все диалоги используют:
- `ClipRRect` для обрезки контента по границам
- `Flexible` с `TextOverflow.ellipsis` для текста
- `BoxConstraints` для ограничения размеров
- `AnimatedOpacity` для плавного появления/исчезновения контента

## Отладка

Для тестирования smooth диалогов используйте debug секцию:

```dart
// В debug экране
DebugSmoothDialogsSection()
```

Доступные тесты:
- **Тест размеров**: изменение размеров диалога
- **Тест обновления контента**: обновление сообщений
- **Тест overflow**: проверка обработки длинного текста
- **Тест маленького диалога**: проверка 80x80 диалога

## Интеграция

Smooth диалоги интегрированы с:
- `GlobalKeyService` для доступа к контексту
- `TalkerService` для логирования
- `GetIt` для dependency injection

## Примеры

Полные примеры использования доступны в:
- `lib/core/utils/examples/smooth_dialog_example.dart`
- `lib/core/utils/debug/presentation/widgets/debug_smooth_dialogs_section.dart` 