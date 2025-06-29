# Сравнение DialogService и SmoothDialogService

В проекте реализованы две системы диалогов, каждая со своими преимуществами и особенностями.

## DialogService (Классическая система)

### Особенности:
- Использует стандартные Flutter диалоги
- Обертывает диалоги в `AnimatedDialogWrapper`
- Поддерживает `AnimatedDialogTransition` для плавных переходов
- Использует `GlobalKeyService` для навигации

### Преимущества:
- Простота использования
- Стандартный внешний вид Flutter
- Легкая кастомизация через стандартные виджеты
- Хорошая производительность

### Недостатки:
- Ограниченные возможности анимации
- Сложность создания единого стиля
- Зависимость от стандартных диалогов Flutter

## SmoothDialogService (Новая система)

### Особенности:
- Все диалоги наследуются от `SmoothDialog`
- Использует `BaseSmoothDialog` для анимаций
- Типизированная архитектура
- Централизованные ключи через `GlobalKeyService`
- Единый стиль и размеры

### Преимущества:
- Строгая типизация
- Легкое создание кастомных диалогов
- Единый стиль для всех диалогов
- Плавные анимации через `AnimatedContainer`
- Лучшая архитектура

### Недостатки:
- Более сложная настройка
- Требует создания классов для каждого типа диалога
- Может быть избыточным для простых случаев

## Сравнение API

### Показ диалогов

| Метод | DialogService | SmoothDialogService |
|-------|---------------|-------------------|
| Загрузка | `showLoading()` | `showLoading()` |
| Загрузка с текстом | `showLoadingWithText(text)` | `showLoadingWithText(text)` |
| Подтверждение | `showConfirmDialog(...)` | `showConfirmDialog(...)` |
| Подтверждение/Отмена | `showConfirmCancelDialog(...)` | `showConfirmCancelDialog(...)` |
| Ошибка | `showErrorDialog(...)` | `showErrorDialog(...)` |
| Информация | `showInfoDialog(...)` | `showInfoDialog(...)` |
| Кастомный | `updateDialog(widget)` | `showCustomDialog(smoothDialog)` |

### Управление диалогами

| Операция | DialogService | SmoothDialogService |
|----------|---------------|-------------------|
| Обновление | `updateDialog(widget)` | `updateDialog(smoothDialog)` |
| Закрытие | `closeDialog()` | `closeDialog()` |
| Состояние | `isDialogShowing` | `isDialogShowing` |
| Текущий диалог | `currentDialog` | `currentDialog` |

## Создание кастомных диалогов

### DialogService
```dart
class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        // кастомный контент
      ),
    );
  }
}

// Использование
dialogService.updateDialog(CustomDialog());
```

### SmoothDialogService
```dart
class CustomSmoothDialog extends SmoothDialog {
  @override
  Widget buildContent(BuildContext context) {
    return Container(
      // кастомный контент
    );
  }

  @override
  double get width => 300;
  @override
  double get height => 200;
  @override
  double get borderRadius => 12;
}

// Использование
smoothDialogService.showCustomDialog(CustomSmoothDialog());
```

## Рекомендации по использованию

### Используйте DialogService когда:
- Нужны простые диалоги
- Требуется быстрая разработка
- Важна совместимость со стандартным Flutter
- Диалоги имеют разный дизайн

### Используйте SmoothDialogService когда:
- Нужен единый стиль для всех диалогов
- Требуются сложные анимации
- Важна типизация и архитектура
- Планируется много кастомных диалогов

## Миграция

Для миграции с `DialogService` на `SmoothDialogService`:

1. Создайте классы диалогов, наследующие от `SmoothDialog`
2. Замените вызовы `updateDialog(widget)` на `showCustomDialog(smoothDialog)`
3. Обновите кастомные диалоги для использования `buildContent`
4. Настройте размеры и стили через геттеры

## Отладка

Обе системы поддерживают отладку через debug секции:
- `DebugDialogsSection` - для DialogService
- `DebugSmoothDialogsSection` - для SmoothDialogService

Доступны в debug экране приложения для тестирования всех возможностей. 