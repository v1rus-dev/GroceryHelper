import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.text);
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: headline1,
    displayMedium: headline2,
    bodyMedium: body,
    labelLarge: button,
  );
}
