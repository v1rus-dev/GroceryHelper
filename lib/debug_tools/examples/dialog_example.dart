import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

/// Пример использования новой системы диалогов
class DialogExample {
  static final StateDialogManager _dialogService = StateDialogManager.instance;

  /// Пример показа диалога загрузки
  static Future<void> showLoadingExample(BuildContext context) async {
    TalkerService.log('DialogExample: showLoadingExample');

    _dialogService.showLoading(text: 'Загружаем данные...');

    TalkerService.log('DialogExample: showLoadingExample: start loading');
    // Симуляция загрузки
    await Future.delayed(const Duration(seconds: 2));

    TalkerService.log('DialogExample: showLoadingExample: loading done');

    // Показываем диалог успеха
    await _dialogService.showSuccess('Данные успешно загружены!', title: 'Загрузка завершена');
  }

  /// Пример показа диалога с кнопками подтверждения и отмены
  static Future<void> showConfirmCancelExample(BuildContext context) async {
    final result = await _dialogService.showConfirmDialog<bool>(
      'Вы уверены, что хотите выполнить это действие?',
      title: 'Подтверждение действия',
      optionsBuilder: () => {'Отмена': false, 'Да, выполнить': true},
    );

    if (result == true) {
      // Показываем диалог загрузки
      _dialogService.showLoading(text: 'Выполняем действие...');

      await Future.delayed(const Duration(seconds: 2));

      await _dialogService.showSuccess('Действие выполнено!', title: 'Готово');
    }
  }

  /// Пример последовательного показа диалогов
  static Future<void> showSequentialDialogsExample(BuildContext context) async {
    // Начинаем с загрузки
    _dialogService.showLoading(text: 'Проверяем данные...');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем ошибку
    await _dialogService.showError('Обнаружены проблемы с данными');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с выбором
    final result = await _dialogService.showConfirmDialog<bool>(
      'Найдено 5 новых элементов. Добавить их в список?',
      title: 'Обработка завершена',
      optionsBuilder: () => {'Пропустить': false, 'Добавить': true},
    );

    if (result == true) {
      await _dialogService.showSuccess('Элементы добавлены в список!');
    }
  }

  /// Пример обработки ошибки с retry
  static Future<void> showErrorWithRetryExample(BuildContext context) async {
    _dialogService.showLoading(text: 'Подключаемся к серверу...');

    await Future.delayed(const Duration(seconds: 1));

    // Симулируем ошибку
    await _dialogService.showError('Не удалось подключиться к серверу. Проверьте интернет-соединение.');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с опциями retry
    final result = await _dialogService.showConfirmDialog<String>(
      'Что вы хотите сделать?',
      title: 'Ошибка подключения',
      optionsBuilder: () => {'Попробовать еще': 'retry', 'Отмена': 'cancel'},
    );

    if (result == 'retry') {
      _dialogService.showLoading(text: 'Повторное подключение...');

      await Future.delayed(const Duration(seconds: 2));

      await _dialogService.showSuccess(
        'Соединение с сервером установлено успешно!',
        title: 'Подключение восстановлено',
      );
    }
  }

  /// Пример кастомного диалога
  static Future<void> showCustomDialogExample(BuildContext context) async {
    _dialogService.showLoading(text: 'Подготавливаем информацию...');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем кастомный диалог с множественными опциями
    final result = await _dialogService.showConfirmDialog<String>(
      'Что вы хотите сделать с этим элементом?',
      title: 'Выберите действие',
      optionsBuilder: () => {
        'Редактировать': 'edit',
        'Удалить': 'delete',
        'Дублировать': 'duplicate',
        'Отмена': 'cancel',
      },
    );

    switch (result) {
      case 'edit':
        await _dialogService.showSuccess('Режим редактирования активирован!');
        break;
      case 'delete':
        await _dialogService.showSuccess('Элемент удален!');
        break;
      case 'duplicate':
        await _dialogService.showSuccess('Элемент продублирован!');
        break;
    }
  }

  /// Простой пример показа диалога загрузки
  static Future<void> showSimpleLoadingExample(BuildContext context) async {
    _dialogService.showLoading(text: 'Загрузка...');
    await Future.delayed(const Duration(seconds: 2));
    await _dialogService.showSuccess('Загрузка завершена!');
  }

  /// Простой пример показа диалога подтверждения
  static Future<void> showSimpleConfirmExample(BuildContext context) async {
    await _dialogService.showConfirmDialog('Это тестовый диалог', title: 'Тест', optionsBuilder: () => {'OK': null});
  }

  /// Простой пример показа диалога подтверждения/отмены
  static Future<void> showSimpleConfirmCancelExample(BuildContext context) async {
    final result = await _dialogService.showConfirmDialog<bool>(
      'Это тестовый диалог с отменой',
      title: 'Тест',
      optionsBuilder: () => {'Отмена': false, 'OK': true},
    );
    print('Результат: $result');
  }
}
