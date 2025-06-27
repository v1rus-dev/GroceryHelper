import 'package:flutter/material.dart';
import 'app_theme.dart';

extension AppThemeExtension on BuildContext {
  /// Получить кастомные цвета темы
  AppThemeColors get theme => Theme.of(this).extension<AppThemeColors>()!;

  /// Получить цвет фона
  Color get backgroundColor => theme.background;

  /// Получить цвет поверхности
  Color get surfaceColor => theme.surface;

  /// Получить цвет текста
  Color get textColor => theme.text;

  /// Получить цвет вторичного текста
  Color get secondaryTextColor => theme.secondaryText;

  /// Получить цвет разделителя
  Color get dividerColor => theme.divider;

  Color get navigationColor => theme.navigation;

  Color get busketColor => theme.busket;

  Color get primaryColor => theme.primary;

  /// Проверить, является ли текущая тема темной
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
