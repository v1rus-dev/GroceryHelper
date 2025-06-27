import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/widgets/app_button.dart';

class DebugButtonsSection extends StatelessWidget {
  const DebugButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Кнопки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        AppButton(onPressed: () {}, text: 'Primary Button'),
        const SizedBox(height: 16),
      ],
    );
  }
}
