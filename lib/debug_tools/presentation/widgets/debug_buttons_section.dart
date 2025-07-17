import 'package:design/design.dart';
import 'package:flutter/material.dart';

class DebugButtonsSection extends StatelessWidget {
  const DebugButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Кнопки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        AppPrimaryButton(onPressed: () {}, text: 'Primary Button'),
        const SizedBox(height: 16),
      ],
    );
  }
}
