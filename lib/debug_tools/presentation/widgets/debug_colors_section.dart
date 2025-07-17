import 'package:flutter/material.dart';
import 'package:design/design.dart';

class DebugColorsSection extends StatelessWidget {
  const DebugColorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Цвета', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        _buildColorBox('Primary', AppColors.primary),
        _buildColorBox('Primary Light', AppColors.primaryLight),
        _buildColorBox('Primary Dark', AppColors.primaryDark),
        _buildColorBox('Navigation', AppColors.navigation),
        _buildColorBox('Background', AppColors.background),
        _buildColorBox('Accent', AppColors.accent),
        _buildColorBox('Error', AppColors.error),
        _buildColorBox('Text', AppColors.text),
        _buildColorBox('Secondary Text', AppColors.secondaryText),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildColorBox(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            '#${color.value.toRadixString(16).toUpperCase().substring(2)}',
            style: TextStyle(color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
