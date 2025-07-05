import 'package:flutter/material.dart';
import 'package:groceryhelper/common_ui/theme/app_colors.dart';
import 'package:groceryhelper/common_ui/theme/app_text_styles.dart';

class DebugChipsSection extends StatelessWidget {
  const DebugChipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Чипы', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            Chip(label: const Text('Чип 1')),
            Chip(
              label: const Text('Чип 2'),
              backgroundColor: AppColors.primaryLight,
              labelStyle: const TextStyle(color: Colors.white),
            ),
            Chip(
              label: const Text('Чип 3'),
              backgroundColor: AppColors.navigation,
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
