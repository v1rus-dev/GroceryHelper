import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_colors.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class DebugButtonsSection extends StatelessWidget {
  const DebugButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Кнопки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        ElevatedButton(onPressed: () {}, child: const Text('Primary Button')),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.navigation),
          child: const Text('Navigation Button'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
