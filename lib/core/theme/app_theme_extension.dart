import 'package:flutter/material.dart';
import 'app_theme.dart';

extension AppThemeExtension on BuildContext {
  /// Получить кастомные цвета темы
  AppThemeColors get themeColors => Theme.of(this).extension<AppThemeColors>()!;

  /// Получить цвет фона
  Color get backgroundColor => themeColors.background;

  /// Получить цвет поверхности
  Color get surfaceColor => themeColors.surface;

  /// Получить цвет текста
  Color get textColor => themeColors.text;

  /// Получить цвет вторичного текста
  Color get secondaryTextColor => themeColors.secondaryText;

  /// Получить цвет разделителя
  Color get dividerColor => themeColors.divider;

  Color get navigationColor => themeColors.navigation;

  /// Проверить, является ли текущая тема темной
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
