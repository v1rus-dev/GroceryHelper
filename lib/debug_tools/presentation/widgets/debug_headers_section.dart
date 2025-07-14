import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/theme/app_text_styles.dart';

class DebugHeadersSection extends StatelessWidget {
  const DebugHeadersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Заголовки', style: AppTextStyles.headline1),
        const SizedBox(height: 8),
        Text('Подзаголовок', style: AppTextStyles.headline2),
        const SizedBox(height: 16),
      ],
    );
  }
}
