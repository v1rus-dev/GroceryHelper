import 'package:flutter/material.dart';
import 'package:design/design.dart';

class DebugSwitchesSection extends StatelessWidget {
  const DebugSwitchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Переключатели', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        Switch(value: true, onChanged: (value) {}, activeColor: AppColors.primaryLight),
        const SizedBox(height: 8),
        Checkbox(value: true, onChanged: (value) {}, activeColor: AppColors.primaryLight),
        const SizedBox(height: 16),
      ],
    );
  }
}
