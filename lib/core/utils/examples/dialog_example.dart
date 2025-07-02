import 'package:flutter/material.dart';
import 'package:groceryhelper/core/services/new_dialog_service.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

/// Пример использования новой системы диалогов
class DialogExample {
  static final NewDialogService _dialogService = locator<NewDialogService>();

  /// Пример показа диалога загрузки
  static Future<void> showLoadingExample(BuildContext context) async {
    TalkerService.log('DialogExample: showLoadingExample');

    _dialogService.showLoading(context, 'Загружаем данные...');

    TalkerService.log('DialogExample: showLoadingExample: start loading');
    // Симуляция загрузки
    await Future.delayed(const Duration(seconds: 2));

    TalkerService.log('DialogExample: showLoadingExample: loading done');

    // Показываем диалог успеха
    await _dialogService.showSuccess(context, 'Данные успешно загружены!', title: 'Загрузка завершена');
  }

  /// Пример показа диалога с кнопками подтверждения и отмены
  static Future<void> showConfirmCancelExample(BuildContext context) async {
    final result = await _dialogService.showConfirmCancelDialog(
      context: context,
      title: 'Подтверждение действия',
      message: 'Вы уверены, что хотите выполнить это действие?',
      confirmButtonText: 'Да, выполнить',
      cancelButtonText: 'Отмена',
    );

    if (result == true) {
      // Показываем диалог загрузки
      _dialogService.showLoading(context, 'Выполняем действие...');

      await Future.delayed(const Duration(seconds: 2));

      // Показываем результат
      await _dialogService.showSuccess(context, 'Действие выполнено успешно!', title: 'Готово!');

      TalkerService.log('DialogExample: showConfirmCancelExample: action completed');
    }
  }

  /// Пример последовательного показа диалогов
  static Future<void> showSequentialDialogsExample(BuildContext context) async {
    // Начинаем с загрузки
    _dialogService.showLoading(context, 'Проверяем данные...');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем ошибку
    await _dialogService.showError(context, 'Обнаружены проблемы с данными');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с выбором
    final result = await _dialogService.showConfirmCancelDialog(
      context: context,
      title: 'Обработка завершена',
      message: 'Найдено 5 новых элементов. Добавить их в список?',
      confirmButtonText: 'Добавить',
      cancelButtonText: 'Пропустить',
    );

    if (result == true) {
      await _dialogService.showSuccess(context, 'Элементы добавлены в список!');
    }
  }

  /// Пример обработки ошибки с retry
  static Future<void> showErrorWithRetryExample(BuildContext context) async {
    _dialogService.showLoading(context, 'Подключаемся к серверу...');

    await Future.delayed(const Duration(seconds: 1));

    // Симулируем ошибку
    await _dialogService.showError(context, 'Не удалось подключиться к серверу. Проверьте интернет-соединение.');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с опциями retry
    final result = await _dialogService.showCustomDialog<String>(
      context: context,
      title: 'Ошибка подключения',
      message: 'Что вы хотите сделать?',
      options: {'Попробовать еще': 'retry', 'Отмена': 'cancel'},
    );

    if (result == 'retry') {
      _dialogService.showLoading(context, 'Повторное подключение...');

      await Future.delayed(const Duration(seconds: 2));

      await _dialogService.showSuccess(
        context,
        'Соединение с сервером установлено успешно!',
        title: 'Подключение восстановлено',
      );
    }
  }

  /// Пример кастомного диалога
  static Future<void> showCustomDialogExample(BuildContext context) async {
    _dialogService.showLoading(context, 'Подготавливаем информацию...');

    await Future.delayed(const Duration(seconds: 1));

    // Показываем кастомный диалог с множественными опциями
    final result = await _dialogService.showCustomDialog<String>(
      context: context,
      title: 'Выберите действие',
      message: 'Что вы хотите сделать с этим элементом?',
      options: {'Редактировать': 'edit', 'Удалить': 'delete', 'Дублировать': 'duplicate', 'Отмена': 'cancel'},
    );

    switch (result) {
      case 'edit':
        await _dialogService.showSuccess(context, 'Режим редактирования активирован!');
        break;
      case 'delete':
        await _dialogService.showSuccess(context, 'Элемент удален!');
        break;
      case 'duplicate':
        await _dialogService.showSuccess(context, 'Элемент продублирован!');
        break;
    }
  }

  /// Простой пример показа диалога загрузки
  static Future<void> showSimpleLoadingExample(BuildContext context) async {
    _dialogService.showLoading(context, 'Загрузка...');
    await Future.delayed(const Duration(seconds: 2));
    await _dialogService.showSuccess(context, 'Загрузка завершена!');
  }

  /// Простой пример показа диалога подтверждения
  static Future<void> showSimpleConfirmExample(BuildContext context) async {
    await _dialogService.showConfirmDialog(context: context, title: 'Тест', message: 'Это тестовый диалог');
  }

  /// Простой пример показа диалога подтверждения/отмены
  static Future<void> showSimpleConfirmCancelExample(BuildContext context) async {
    final result = await _dialogService.showConfirmCancelDialog(
      context: context,
      title: 'Тест',
      message: 'Это тестовый диалог с отменой',
    );
    print('Результат: $result');
  }
}
