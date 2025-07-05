import 'package:flutter/material.dart';
import 'package:groceryhelper/common_ui/theme/app_colors.dart';
import 'package:groceryhelper/common_ui/theme/app_text_styles.dart';

class DebugIconsSection extends StatelessWidget {
  const DebugIconsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Иконки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.home, color: AppColors.primaryLight, size: 32),
            const SizedBox(width: 16),
            Icon(Icons.shopping_cart, color: AppColors.navigation, size: 32),
            const SizedBox(width: 16),
            Icon(Icons.person, color: AppColors.accent, size: 32),
            const SizedBox(width: 16),
            Icon(Icons.error, color: AppColors.error, size: 32),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
