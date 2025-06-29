import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/utils/examples/dialog_example.dart';

class DebugDialogsSection extends StatelessWidget {
  const DebugDialogsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Диалоги', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElevatedButton(onPressed: () => DialogExample.showLoadingExample(), child: const Text('Загрузка')),
            ElevatedButton(
              onPressed: () => DialogExample.showConfirmCancelExample(),
              child: const Text('Подтверждение'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSequentialDialogsExample(),
              child: const Text('Последовательность'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showErrorWithRetryExample(),
              child: const Text('Ошибка + Retry'),
            ),
            ElevatedButton(onPressed: () => DialogExample.showCustomDialogExample(), child: const Text('Кастомный')),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleLoadingExample(),
              child: const Text('Простая загрузка'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleConfirmExample(),
              child: const Text('Простое подтверждение'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleConfirmCancelExample(),
              child: const Text('Подтверждение/отмена'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Особенности новой системы диалогов:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          '• Плавные переходы между диалогами\n'
          '• Анимации изменения размеров и контента\n'
          '• Единый стиль для всех диалогов\n'
          '• Поддержка кастомных диалогов\n'
          '• Отслеживание состояния диалогов',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
