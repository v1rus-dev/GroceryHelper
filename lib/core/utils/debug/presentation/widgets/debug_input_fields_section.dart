import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/widgets/app_text_field.dart';

class DebugInputFieldsSection extends StatelessWidget {
  const DebugInputFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Поля ввода', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        AppTextField(hintText: 'Поиск...'),
        const SizedBox(height: 8),
        AppTextField(hintText: 'Пароль', isPassword: true),
        const SizedBox(height: 16),
      ],
    );
  }
}
