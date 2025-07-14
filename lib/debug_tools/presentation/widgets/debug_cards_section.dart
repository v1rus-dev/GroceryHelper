import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/theme/app_text_styles.dart';

class DebugCardsSection extends StatelessWidget {
  const DebugCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Карточки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Заголовок карточки', style: AppTextStyles.headline2),
                const SizedBox(height: 8),
                Text('Содержимое карточки с обычным текстом', style: AppTextStyles.body),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
