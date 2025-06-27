import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class DebugInputFieldsSection extends StatelessWidget {
  const DebugInputFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Поля ввода', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(labelText: 'Обычное поле', hintText: 'Введите текст'),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Поле с иконкой',
            hintText: 'Введите текст',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
