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
            ElevatedButton(onPressed: () => DialogExample.showLoadingExample(context), child: const Text('Загрузка')),
            ElevatedButton(
              onPressed: () => DialogExample.showConfirmCancelExample(context),
              child: const Text('Подтверждение'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSequentialDialogsExample(context),
              child: const Text('Последовательность'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showErrorWithRetryExample(context),
              child: const Text('Ошибка + Retry'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showCustomDialogExample(context),
              child: const Text('Кастомный'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleLoadingExample(context),
              child: const Text('Простая загрузка'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleConfirmExample(context),
              child: const Text('Простое подтверждение'),
            ),
            ElevatedButton(
              onPressed: () => DialogExample.showSimpleConfirmCancelExample(context),
              child: const Text('Подтверждение/отмена'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Особенности новой системы диалогов:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          '• Простой API с передачей контекста\n'
          '• Автоматическое управление состоянием диалогов\n'
          '• Предотвращение наложения диалогов\n'
          '• Поддержка кастомных диалогов с произвольными опциями\n'
          '• Единообразный стиль для всех диалогов\n'
          '• Логирование всех операций',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 16),
        const Text('Доступные методы:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          '• showLoading(context, text) - диалог загрузки\n'
          '• showSuccess(context, message) - диалог успеха\n'
          '• showError(context, message) - диалог ошибки\n'
          '• showConfirmDialog(context, title, message) - подтверждение\n'
          '• showConfirmCancelDialog(context, title, message) - подтверждение/отмена\n'
          '• showCustomDialog(context, title, message, options) - кастомный диалог',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
