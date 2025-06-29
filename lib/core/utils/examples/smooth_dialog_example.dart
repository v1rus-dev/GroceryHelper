import 'package:flutter/material.dart';
import 'package:groceryhelper/core/services/smooth_dialog_service.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dialog.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_loading_dialog.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dualog_confirm.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'dart:async';

/// Пример использования Smooth диалогов
class SmoothDialogExample {
  static final SmoothDialogService _smoothDialogService = locator<SmoothDialogService>();

  /// Показать smooth диалог загрузки
  static Future<void> showLoadingExample() async {
    TalkerService.log('SmoothDialogExample: showLoadingExample');
    _smoothDialogService.showLoading();

    TalkerService.log('SmoothDialogExample: showLoadingExample: start loading');
    // Симуляция загрузки
    await Future.delayed(const Duration(seconds: 2));

    TalkerService.log('SmoothDialogExample: showLoadingExample: loading done');

    TalkerService.log('SmoothDialogExample: showLoadingExample: update dialog with text');

    // Обновляем диалог с текстом (БЕЗ закрытия!)
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Загружаем данные...'));

    TalkerService.log('SmoothDialogExample: showLoadingExample: update dialog with text done');

    await Future.delayed(const Duration(seconds: 2));

    // Показываем диалог подтверждения (БЕЗ закрытия!)
    final result = await _smoothDialogService.updateDialog(
      SmoothDialogConfirm(
        title: 'Загрузка завершена',
        message: 'Данные успешно загружены. Продолжить?',
        confirmButtonText: 'Продолжить',
        cancelButtonText: 'Отмена',
      ),
    );

    TalkerService.log('SmoothDialogExample: showLoadingExample: result: $result');
  }

  /// Пример правильного обновления диалога без закрытия
  static Future<void> showUpdateDialogExample() async {
    TalkerService.log('SmoothDialogExample: showUpdateDialogExample: start');

    // Показываем начальный диалог загрузки
    _smoothDialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с текстом (диалог остается открытым)
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Шаг 1: Проверяем данные...'));

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с другим текстом (диалог остается открытым)
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Шаг 2: Обрабатываем информацию...'));

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с третьим текстом (диалог остается открытым)
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Шаг 3: Сохраняем результаты...'));

    await Future.delayed(const Duration(seconds: 1));

    // Финальное обновление с диалогом подтверждения (диалог остается открытым)
    final result = await _smoothDialogService.updateDialog(
      SmoothDialogConfirm(
        title: 'Обработка завершена!',
        message: 'Все данные успешно обработаны и сохранены.',
        confirmButtonText: 'Отлично!',
        cancelButtonText: 'Отлично!',
      ),
    );

    TalkerService.log('SmoothDialogExample: showUpdateDialogExample: result: $result');
  }

  /// Показать smooth диалог загрузки с текстом
  static Future<void> showLoadingWithTextExample() async {
    _smoothDialogService.showLoadingWithText('Загрузка данных...');
    await Future.delayed(const Duration(seconds: 3));
    _smoothDialogService.closeDialog();
  }

  /// Показать маленький smooth диалог загрузки
  static Future<void> showSmallLoadingExample() async {
    _smoothDialogService.showCustomDialog(SmoothLoadingDialog());
    await Future.delayed(const Duration(seconds: 3));
    _smoothDialogService.closeDialog();
  }

  /// Пример показа smooth диалога с одной кнопкой подтверждения
  static Future<void> showConfirmDialogExample() async {
    final result = await _smoothDialogService.showConfirmDialog(
      title: 'Подтверждение',
      message: 'Вы уверены, что хотите продолжить?',
      confirmButtonText: 'Да',
    );

    if (result == true) {
      print('Пользователь подтвердил действие');
    }
  }

  /// Пример показа smooth диалога с кнопками подтверждения и отмены
  static Future<void> showConfirmCancelDialogExample() async {
    final result = await _smoothDialogService.showConfirmCancelDialog(
      title: 'Подтверждение действия',
      message: 'Вы уверены, что хотите выполнить это действие?',
      confirmButtonText: 'Да, выполнить',
      cancelButtonText: 'Отмена',
    );

    if (result == true) {
      // Показываем диалог загрузки
      _smoothDialogService.showLoadingWithText('Выполняем действие...');

      await Future.delayed(const Duration(seconds: 2));

      // Показываем результат
      final result = await _smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Готово!',
          message: 'Действие выполнено успешно.',
          confirmButtonText: 'OK',
          cancelButtonText: 'OK',
        ),
      );

      TalkerService.log('SmoothDialogExample: showConfirmCancelDialogExample: result: $result');
    }
  }

  /// Пример последовательного показа smooth диалогов
  static Future<void> showSequentialDialogsExample() async {
    // Начинаем с загрузки
    _smoothDialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с текстом
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Проверяем данные...'));

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с другим текстом
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Обрабатываем информацию...'));

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с выбором
    await _smoothDialogService.updateDialog(
      SmoothDialogConfirm(
        title: 'Обработка завершена',
        message: 'Найдено 5 новых элементов. Добавить их в список?',
        confirmButtonText: 'Добавить',
        cancelButtonText: 'Пропустить',
      ),
    );
  }

  /// Пример обработки ошибки с retry
  static Future<void> showErrorWithRetryExample() async {
    _smoothDialogService.showLoadingWithText('Подключаемся к серверу...');

    await Future.delayed(const Duration(seconds: 1));

    // Симулируем ошибку
    final shouldRetry = await _smoothDialogService.showErrorDialog(
      title: 'Ошибка подключения',
      message: 'Не удалось подключиться к серверу. Проверьте интернет-соединение.',
      retryButtonText: 'Попробовать еще',
      closeButtonText: 'Отмена',
      onRetry: () async {
        // Закрываем диалог ошибки
        _smoothDialogService.closeDialog();

        // Показываем загрузку снова
        _smoothDialogService.showLoadingWithText('Повторное подключение...');

        await Future.delayed(const Duration(seconds: 2));

        // Показываем успех
        await _smoothDialogService.updateDialog(
          SmoothDialogConfirm(
            title: 'Подключение восстановлено',
            message: 'Соединение с сервером установлено успешно.',
            confirmButtonText: 'Продолжить',
            cancelButtonText: 'Продолжить',
          ),
        );
      },
    );

    if (shouldRetry == false) {
      _smoothDialogService.closeDialog();
    }
  }

  /// Пример показа smooth диалога с ошибкой
  static Future<void> showErrorDialogExample() async {
    final result = await _smoothDialogService.showErrorDialog(
      title: 'Ошибка',
      message: 'Произошла ошибка при загрузке данных',
      retryButtonText: 'Повторить',
      closeButtonText: 'Закрыть',
      onRetry: () {
        print('Повторная попытка загрузки');
      },
    );

    if (result == true) {
      print('Пользователь выбрал повторить');
    } else {
      print('Пользователь закрыл диалог');
    }
  }

  /// Пример показа smooth диалога с информацией
  static Future<void> showInfoDialogExample() async {
    _smoothDialogService.showInfoDialog(
      title: 'Информация',
      message: 'Операция выполнена успешно!',
      buttonText: 'Понятно',
    );
  }

  /// Пример показа кастомного smooth диалога
  static Future<void> showCustomDialogExample() async {
    _smoothDialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Показываем кастомный диалог
    await _smoothDialogService.showCustomDialog(
      CustomSmoothDialog(
        title: 'Информация',
        message: 'Это пример кастомного smooth диалога с дополнительной информацией.',
      ),
    );
  }

  /// Тест для проверки исправления overflow при обновлении диалогов
  static Future<void> showOverflowTestExample() async {
    TalkerService.log('SmoothDialogExample: showOverflowTestExample: start');

    // Тест 1: Маленький диалог (80x80)
    _smoothDialogService.showCustomDialog(SmoothLoadingDialog());
    await Future.delayed(const Duration(seconds: 1));

    // Тест 2: Быстрое обновление на большой диалог (350x200)
    _smoothDialogService.updateDialog(
      SmoothDialogConfirm(
        title: 'Очень длинный заголовок который может вызвать overflow',
        message:
            'Это очень длинное сообщение которое может вызвать overflow в диалоге. Оно должно правильно обрезаться и не выходить за границы контейнера.',
        confirmButtonText: 'Подтвердить',
        cancelButtonText: 'Отмена',
      ),
    );
    await Future.delayed(const Duration(seconds: 2));

    // Тест 3: Обратно на маленький диалог (80x80)
    _smoothDialogService.updateDialog(SmoothLoadingDialog());
    await Future.delayed(const Duration(seconds: 1));

    // Тест 4: На диалог с длинным текстом (200x120)
    _smoothDialogService.updateDialog(
      SmoothLoadingDialog(text: 'Очень длинный текст загрузки который может вызвать overflow в диалоге загрузки'),
    );
    await Future.delayed(const Duration(seconds: 2));

    _smoothDialogService.closeDialog();
    TalkerService.log('SmoothDialogExample: showOverflowTestExample: completed');
  }

  /// Тест для проверки правильных размеров диалогов
  static Future<void> showSizeTestExample() async {
    TalkerService.log('SmoothDialogExample: showSizeTestExample: start');

    // Тест 1: Маленький диалог загрузки (80x80)
    _smoothDialogService.showCustomDialog(SmoothLoadingDialog());
    await Future.delayed(const Duration(seconds: 2));

    // Тест 2: Обычный диалог загрузки (200x80)
    _smoothDialogService.updateDialog(SmoothLoadingDialog());
    await Future.delayed(const Duration(seconds: 2));

    // Тест 3: Диалог загрузки с текстом (200x120)
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Загружаем...'));
    await Future.delayed(const Duration(seconds: 2));

    // Тест 4: Диалог подтверждения (350x200)
    final result = await _smoothDialogService.updateDialog(
      SmoothDialogConfirm(
        title: 'Тест размеров',
        message: 'Этот диалог должен быть 350x200 пикселей',
        confirmButtonText: 'OK',
        cancelButtonText: 'Отмена',
      ),
    );

    TalkerService.log('SmoothDialogExample: showSizeTestExample: result: $result');
  }

  /// Простой тест для проверки исправления ошибки с Theme.of(context)
  static Future<void> showSimpleTestExample() async {
    TalkerService.log('SmoothDialogExample: showSimpleTestExample: start');

    // Простой диалог загрузки
    _smoothDialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем на диалог с текстом
    _smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Тест обновления'));

    await Future.delayed(const Duration(seconds: 1));

    // Закрываем диалог
    _smoothDialogService.closeDialog();

    TalkerService.log('SmoothDialogExample: showSimpleTestExample: completed');
  }

  /// Закрыть текущий smooth диалог
  static void closeCurrentDialog() {
    _smoothDialogService.closeDialog();
  }

  void _showSizeChangeExample() {
    final smoothDialogService = locator<SmoothDialogService>();

    // Показываем маленький диалог загрузки
    smoothDialogService.showCustomDialog(SmoothLoadingDialog());

    // Через 2 секунды изменяем размер на большой
    Future.delayed(const Duration(seconds: 2), () {
      smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Загрузка завершена!'));
    });

    // Через 4 секунды показываем диалог подтверждения
    Future.delayed(const Duration(seconds: 4), () {
      smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Подтверждение',
          message: 'Операция выполнена успешно!',
          confirmButtonText: 'OK',
          cancelButtonText: 'OK',
        ),
      );
    });
  }

  void _showContentUpdateExample() {
    final smoothDialogService = locator<SmoothDialogService>();

    // Показываем диалог загрузки
    smoothDialogService.showCustomDialog(SmoothLoadingDialog(text: 'Подготовка данных...'));

    // Обновляем сообщение каждую секунду
    int step = 1;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      step++;
      if (step > 5) {
        timer.cancel();
        smoothDialogService.closeDialog();
        return;
      }

      smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Шаг $step из 5...'));
    });
  }

  void _showOverflowTest() {
    final smoothDialogService = locator<SmoothDialogService>();

    // Показываем маленький диалог
    smoothDialogService.showCustomDialog(SmoothLoadingDialog());

    // Через 2 секунды показываем очень длинный текст
    Future.delayed(const Duration(seconds: 2), () {
      smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Очень длинный заголовок диалога который может не поместиться',
          message:
              'Это очень длинное сообщение которое содержит много текста и может вызвать проблемы с отображением в маленьком диалоге. Мы должны убедиться что текст правильно обрезается и не выходит за границы.',
          confirmButtonText: 'Подтвердить',
          cancelButtonText: 'Отмена',
        ),
      );
    });
  }
}

// Пример кастомного smooth диалога
class CustomSmoothDialog extends SmoothDialog {
  final String title;
  final String message;

  CustomSmoothDialog({required this.title, required this.message});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info_outline, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Понятно')),
          ),
        ],
      ),
    );
  }

  @override
  double get width => 350;

  @override
  double get height => 250;

  @override
  double get borderRadius => 16;
}
