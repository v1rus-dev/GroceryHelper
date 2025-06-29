import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_colors.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/utils/examples/smooth_dialog_example.dart';
import 'package:groceryhelper/core/services/smooth_dialog_service.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_loading_dialog.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dualog_confirm.dart';
import 'package:get_it/get_it.dart';
import 'dart:async';

class DebugSmoothDialogsSection extends StatelessWidget {
  const DebugSmoothDialogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Smooth Диалоги', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(onPressed: () => SmoothDialogExample.showLoadingExample(), child: const Text('Загрузка')),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showSmallLoadingExample(),
              child: const Text('Маленькая загрузка'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showSimpleTestExample(),
              child: const Text('Простой тест'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showSizeTestExample(),
              child: const Text('Тест размеров'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showOverflowTestExample(),
              child: const Text('Тест Overflow'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showLoadingWithTextExample(),
              child: const Text('Загрузка с текстом'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showConfirmDialogExample(),
              child: const Text('Подтверждение'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showConfirmCancelDialogExample(),
              child: const Text('Подтверждение/Отмена'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showErrorDialogExample(),
              child: const Text('Ошибка + Retry'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showSequentialDialogsExample(),
              child: const Text('Последовательность'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showUpdateDialogExample(),
              child: const Text('Обновление диалога'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showInfoDialogExample(),
              child: const Text('Информация'),
            ),
            ElevatedButton(
              onPressed: () => SmoothDialogExample.showCustomDialogExample(),
              child: const Text('Кастомный'),
            ),
            ElevatedButton(onPressed: _showFirstShowVsUpdateTest, child: const Text('Первый показ vs Обновление')),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Особенности Smooth диалогов:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          '• Плавные анимации через BaseSmoothDialog\n'
          '• Типизированные диалоги (наследуются от SmoothDialog)\n'
          '• Централизованные ключи через GlobalKeyService\n'
          '• Легкое создание кастомных диалогов\n'
          '• Анимированные переходы между состояниями\n'
          '• Единый стиль и размеры для всех диалогов',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showSizeChangeTest() {
    final smoothDialogService = GetIt.I<SmoothDialogService>();

    // Показываем маленький диалог
    smoothDialogService.showCustomDialog(SmoothLoadingDialog());

    // Через 2 секунды изменяем на большой
    Future.delayed(const Duration(seconds: 2), () {
      smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Большой диалог'));
    });

    // Через 4 секунды показываем диалог подтверждения
    Future.delayed(const Duration(seconds: 4), () {
      smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Тест размеров',
          message: 'Диалог изменил размер!',
          confirmButtonText: 'OK',
          cancelButtonText: 'OK',
        ),
      );
    });
  }

  void _showContentUpdateTest() {
    final smoothDialogService = GetIt.I<SmoothDialogService>();

    // Показываем диалог загрузки
    smoothDialogService.showCustomDialog(SmoothLoadingDialog(text: 'Начинаем...'));

    // Обновляем контент каждую секунду
    int step = 1;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      step++;
      if (step > 3) {
        timer.cancel();
        smoothDialogService.closeDialog();
        return;
      }

      smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Шаг $step из 3'));
    });
  }

  void _showOverflowTest() {
    final smoothDialogService = GetIt.I<SmoothDialogService>();

    // Показываем маленький диалог
    smoothDialogService.showCustomDialog(SmoothLoadingDialog());

    // Через 2 секунды показываем длинный текст
    Future.delayed(const Duration(seconds: 2), () {
      smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Очень длинный заголовок который может не поместиться в маленький диалог',
          message:
              'Это очень длинное сообщение которое содержит много текста и может вызвать проблемы с отображением. Текст должен правильно обрезаться.',
          confirmButtonText: 'Подтвердить',
          cancelButtonText: 'Отмена',
        ),
      );
    });
  }

  void _showFirstShowVsUpdateTest() {
    final smoothDialogService = GetIt.I<SmoothDialogService>();

    // Первый показ - контент появляется сразу
    smoothDialogService.showCustomDialog(SmoothLoadingDialog(text: 'Первый показ - контент появляется сразу'));

    // Через 3 секунды обновляем - контент появляется с задержкой
    Future.delayed(const Duration(seconds: 3), () {
      smoothDialogService.updateDialog(SmoothLoadingDialog(text: 'Обновление - контент появляется с задержкой'));
    });

    // Через 6 секунд еще раз обновляем
    Future.delayed(const Duration(seconds: 6), () {
      smoothDialogService.updateDialog(
        SmoothDialogConfirm(
          title: 'Еще одно обновление',
          message: 'Снова с задержкой',
          confirmButtonText: 'OK',
          cancelButtonText: 'OK',
        ),
      );
    });
  }
}
