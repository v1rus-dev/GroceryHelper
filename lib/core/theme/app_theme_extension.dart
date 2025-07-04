import 'package:flutter/material.dart';
import 'app_theme.dart';

extension AppThemeExtension on BuildContext {
  /// Получить кастомные цвета темы
  AppThemeColors get theme => Theme.of(this).extension<AppThemeColors>()!;

  /// Проверить, является ли текущая тема темной
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}
