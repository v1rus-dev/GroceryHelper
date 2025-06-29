# Система диалогов

Новая система диалогов предоставляет единообразный интерфейс для показа различных типов диалогов с поддержкой плавных переходов между ними.

## Структура файлов

```
lib/core/dialogs/
├── base_dialog.dart              # Базовый класс для всех диалогов
├── loading_dialog.dart           # Диалог загрузки без текста
├── loading_with_text_dialog.dart # Диалог загрузки с текстом
├── confirm_dialog.dart           # Диалог с одной кнопкой
├── confirm_cancel_dialog.dart    # Диалог с двумя кнопками
├── error_dialog.dart             # Диалог ошибки (для совместимости)
├── animated_dialog_wrapper.dart  # Обертка для анимации входа
├── animated_dialog_transition.dart # Анимация перехода между диалогами
└── dialogs.dart                  # Экспорт всех диалогов

lib/core/utils/examples/
├── dialog_example.dart           # Примеры использования диалогов
├── error_handler_example.dart    # Примеры обработки ошибок
├── universal_validation_example.dart # Примеры валидации
└── examples.dart                 # Экспорт всех примеров
```

## Особенности

- **Плавные переходы**: Анимированные переходы между диалогами без закрытия
- **Единый стиль**: Все диалоги используют общий дизайн-систему
- **Типизированные диалоги**: Предопределенные типы для частых случаев
- **Кастомные диалоги**: Возможность создания собственных диалогов
- **Отслеживание состояния**: Система знает, какой диалог показывается

## Типы диалогов

### 1. Загрузка без текста
```dart
DialogService.instance.showLoading();
```

### 2. Загрузка с текстом
```dart
DialogService.instance.showLoadingWithText('Загружаем данные...');
```

### 3. Диалог с одной кнопкой подтверждения
```dart
final result = await DialogService.instance.showConfirmDialog(
  title: 'Заголовок',
  message: 'Сообщение',
  confirmButtonText: 'OK',
);
```

### 4. Диалог с кнопками подтверждения и отмены
```dart
final result = await DialogService.instance.showConfirmCancelDialog(
  title: 'Подтверждение',
  message: 'Вы уверены?',
  confirmButtonText: 'Да',
  cancelButtonText: 'Нет',
);
```

## Плавные переходы

### Обновление диалога
```dart
// Показываем загрузку
DialogService.instance.showLoading();

// Обновляем с текстом (плавный переход)
DialogService.instance.updateDialog(
  LoadingWithTextDialog(text: 'Обрабатываем...'),
);

// Показываем результат
final result = await DialogService.instance.updateDialog(
  ConfirmDialog(
    title: 'Готово',
    message: 'Операция завершена',
    confirmButtonText: 'OK',
  ),
);
```

### Пример последовательности
```dart
// 1. Начинаем с загрузки
DialogService.instance.showLoading();

// 2. Обновляем с текстом
DialogService.instance.updateDialog(
  LoadingWithTextDialog(text: 'Проверяем данные...'),
);

// 3. Показываем диалог выбора
final result = await DialogService.instance.updateDialog(
  ConfirmCancelDialog(
    title: 'Найдены новые данные',
    message: 'Добавить их в список?',
    confirmButtonText: 'Добавить',
    cancelButtonText: 'Пропустить',
  ),
);
```

## Кастомные диалоги

Вы можете создавать собственные диалоги, наследуясь от `BaseDialog`:

```dart
import 'package:groceryhelper/core/dialogs/base_dialog.dart';

class CustomInfoDialog extends BaseDialog {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: iconColor),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(message),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
```

## Управление диалогами

### Закрытие диалога
```dart
DialogService.instance.closeDialog();
```

### Проверка состояния
```dart
if (DialogService.instance.isDialogShowing) {
  // Диалог показывается
}

final currentDialog = DialogService.instance.currentDialog;
```

## Анимации

### Вход диалога
- Масштабирование от 0.8 до 1.0 с кривой `Curves.easeOutBack`
- Прозрачность от 0.0 до 1.0 с кривой `Curves.easeOut`
- Длительность: 300ms

### Переход между диалогами
- Плавное изменение прозрачности старого и нового диалога
- Легкое масштабирование для эффекта "дыхания"
- Длительность: 400ms

## Интеграция с ErrorHandler

Система диалогов интегрирована с `ErrorHandler` для показа ошибок:

```dart
try {
  // Некоторые операции
} catch (error, stackTrace) {
  await ErrorHandler.handle(error, stackTrace);
}
```

## Примеры использования

Смотрите файл `lib/core/utils/examples/dialog_example.dart` для полных примеров использования всех типов диалогов.

## Тестирование

В debug экране доступна секция "Диалоги" с кнопками для тестирования всех возможностей системы.

## Архитектура

### Основные классы

- `DialogService` - основной сервис для управления диалогами
- `BaseDialog` - базовый класс для всех диалогов
- `AnimatedDialogWrapper` - обертка для анимации входа
- `AnimatedDialogTransition` - анимация перехода между диалогами

### Типы диалогов

- `LoadingDialog` - загрузка без текста
- `LoadingWithTextDialog` - загрузка с текстом
- `ConfirmDialog` - диалог с одной кнопкой
- `ConfirmCancelDialog` - диалог с двумя кнопками
- `ErrorDialog` - диалог ошибки (для обратной совместимости)

### Важные замечания

- **Диалоги загрузки** (`showLoading`, `showLoadingWithText`) не используют `await`, так как они не возвращают результат
- **Диалоги с кнопками** (`showConfirmDialog`, `showConfirmCancelDialog`) используют `await` для получения результата
- **Обновление диалогов** (`updateDialog`) может использовать `await` только если новый диалог возвращает результат
- **Закрытие диалогов** (`closeDialog`) не использует `await`, так как это синхронная операция

## Лучшие практики

1. **Используйте плавные переходы** для улучшения UX
2. **Показывайте прогресс** при длительных операциях
3. **Давайте пользователю выбор** в критических ситуациях
4. **Используйте понятные заголовки** и сообщения
5. **Тестируйте на разных размерах экрана**
6. **Создавайте кастомные диалоги** для специфических случаев
7. **Используйте единый импорт** через `dialogs.dart`
8. **Изучайте примеры** в папке `core/utils/examples/` 