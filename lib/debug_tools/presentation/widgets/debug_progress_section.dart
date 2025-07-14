import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/theme/app_colors.dart';
import 'package:groceryhelper/shared_ui/theme/app_text_styles.dart';

class DebugProgressSection extends StatelessWidget {
  const DebugProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Прогресс', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.7,
          backgroundColor: AppColors.primaryBackground,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight),
        ),
        const SizedBox(height: 8),
        CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryLight)),
        const SizedBox(height: 16),
      ],
    );
  }
}
