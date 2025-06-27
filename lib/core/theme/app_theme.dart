import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimens.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'Nunito',
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryLight),
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryLight, foregroundColor: Colors.white, elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.radiusM)),
        textStyle: AppTextStyles.button,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppDimens.radiusS)),
    ),
  );
}
