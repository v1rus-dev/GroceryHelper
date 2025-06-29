import 'package:flutter/material.dart';
import 'package:groceryhelper/core/services/dialog_service.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/dialogs/dialogs.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

/// Пример использования новой системы диалогов
class DialogExample {
  static final DialogService _dialogService = locator<DialogService>();

  /// Пример показа диалога загрузки
  static Future<void> showLoadingExample() async {
    TalkerService.log('DialogExample: showLoadingExample');
    _dialogService.showLoading();

    TalkerService.log('DialogExample: showLoadingExample: start loading');
    // Симуляция загрузки
    await Future.delayed(const Duration(seconds: 2));

    TalkerService.log('DialogExample: showLoadingExample: loading done');

    TalkerService.log('DialogExample: showLoadingExample: update dialog with text');

    // Обновляем диалог с текстом
    _dialogService.updateDialog(const LoadingWithTextDialog(text: 'Загружаем данные...'));

    TalkerService.log('DialogExample: showLoadingExample: update dialog with text done');

    await Future.delayed(const Duration(seconds: 2));

    // Показываем диалог подтверждения
    final result = await _dialogService.updateDialog(
      const ConfirmDialog(
        title: 'Загрузка завершена',
        message: 'Данные успешно загружены. Продолжить?',
        confirmButtonText: 'Продолжить',
      ),
    );

    TalkerService.log('DialogExample: showLoadingExample: result: $result');
  }

  /// Пример показа диалога с кнопками подтверждения и отмены
  static Future<void> showConfirmCancelExample() async {
    final result = await _dialogService.showConfirmCancelDialog(
      title: 'Подтверждение действия',
      message: 'Вы уверены, что хотите выполнить это действие?',
      confirmButtonText: 'Да, выполнить',
      cancelButtonText: 'Отмена',
    );

    if (result == true) {
      // Показываем диалог загрузки
      _dialogService.showLoadingWithText('Выполняем действие...');

      await Future.delayed(const Duration(seconds: 2));

      // Показываем результат
      final result = await _dialogService.updateDialog(
        const ConfirmDialog(title: 'Готово!', message: 'Действие выполнено успешно.', confirmButtonText: 'OK'),
      );

      TalkerService.log('DialogExample: showConfirmCancelExample: result: $result');
    }
  }

  /// Пример последовательного показа диалогов
  static Future<void> showSequentialDialogsExample() async {
    // Начинаем с загрузки
    _dialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с текстом
    _dialogService.updateDialog(const LoadingWithTextDialog(text: 'Проверяем данные...'));

    await Future.delayed(const Duration(seconds: 1));

    // Обновляем с другим текстом
    _dialogService.updateDialog(const LoadingWithTextDialog(text: 'Обрабатываем информацию...'));

    await Future.delayed(const Duration(seconds: 1));

    // Показываем диалог с выбором
    await _dialogService.updateDialog(
      const ConfirmCancelDialog(
        title: 'Обработка завершена',
        message: 'Найдено 5 новых элементов. Добавить их в список?',
        confirmButtonText: 'Добавить',
        cancelButtonText: 'Пропустить',
      ),
    );
  }

  /// Пример обработки ошибки с retry
  static Future<void> showErrorWithRetryExample() async {
    _dialogService.showLoadingWithText('Подключаемся к серверу...');

    await Future.delayed(const Duration(seconds: 1));

    // Симулируем ошибку
    final shouldRetry = await _dialogService.showErrorDialog(
      title: 'Ошибка подключения',
      message: 'Не удалось подключиться к серверу. Проверьте интернет-соединение.',
      retryButtonText: 'Попробовать еще',
      closeButtonText: 'Отмена',
      onRetry: () async {
        // Закрываем диалог ошибки
        _dialogService.closeDialog();

        // Показываем загрузку снова
        _dialogService.showLoadingWithText('Повторное подключение...');

        await Future.delayed(const Duration(seconds: 2));

        // Показываем успех
        await _dialogService.updateDialog(
          const ConfirmDialog(
            title: 'Подключение восстановлено',
            message: 'Соединение с сервером установлено успешно.',
            confirmButtonText: 'Продолжить',
          ),
        );
      },
    );

    if (shouldRetry == false) {
      _dialogService.closeDialog();
    }
  }

  /// Пример кастомного диалога
  static Future<void> showCustomDialogExample() async {
    _dialogService.showLoading();

    await Future.delayed(const Duration(seconds: 1));

    // Показываем кастомный диалог
    await _dialogService.updateDialog(
      const CustomInfoDialog(
        title: 'Информация',
        message: 'Это пример кастомного диалога с дополнительной информацией.',
        icon: Icons.info_outline,
        iconColor: Colors.blue,
      ),
    );
  }

  /// Простой пример показа диалога загрузки
  static Future<void> showSimpleLoadingExample() async {
    _dialogService.showLoading();
    await Future.delayed(const Duration(seconds: 2));
    _dialogService.closeDialog();
  }

  /// Простой пример показа диалога подтверждения
  static Future<void> showSimpleConfirmExample() async {
    await _dialogService.showConfirmDialog(title: 'Тест', message: 'Это тестовый диалог');
  }

  /// Простой пример показа диалога подтверждения/отмены
  static Future<void> showSimpleConfirmCancelExample() async {
    final result = await _dialogService.showConfirmCancelDialog(
      title: 'Тест',
      message: 'Это тестовый диалог с отменой',
    );
    print('Результат: $result');
  }
}

/// Пример кастомного диалога
class CustomInfoDialog extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: iconColor),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(message, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Понятно')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
