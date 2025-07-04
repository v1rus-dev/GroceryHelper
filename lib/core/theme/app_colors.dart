import 'package:flutter/material.dart';

class AppColors {
  // Основной цвет
  static const Color primary = Color(0xFF0AB90A); // основной цвет приложения

  // Оттенки primary цвета
  static final Color primaryLight = primary.withValues(alpha: 0.8);
  static final Color primaryDark = primary.withValues(alpha: 0.6);
  static final Color primaryBackground = primary.withValues(alpha: 0.1);

  // Цвет навигации
  static final Color navigation = primary; // только для навигации
  static final Color navigationDark = primaryDark;

  // Корзины
  static final Color primaryBusket = Color(0xFF1E5FEA);

  // Оттенки Busket primary
  static final Color primaryBusketLight = primaryBusket.withValues(alpha: 0.8);
  static final Color primaryBusketDark = primaryBusket.withValues(alpha: 0.6);

  // Системные цвета
  static const Color background = Colors.white; // глобальный фон
  static const Color white = Colors.white; // белый цвет
  static const Color accent = Color(0xFFFF6B6B);
  static const Color error = Color(0xFFE74C3C);
  static const Color text = Color(0xFF2D264B);
  static final Color secondaryText = Color(0xFFBABABA);
  static final Color divider = Color(0xFFEFEFEF);
  static final Color border = Color(0xFFEFEFEF);
  static final Color textFieldBackground = Color(0xFFBDBDBD).withValues(alpha: 0.1);

  // Цвета для темной темы
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkText = Colors.white;
  static const Color darkSecondaryText = Color(0xFFB0B0B0);
  static final Color darkDivider = Color(0xFF2A2A2A);
  static final Color darkBorder = Color(0xFF2A2A2A);
  static final Color darkTextFieldBackground = Color.fromARGB(255, 97, 97, 97).withValues(alpha: 0.1);
}
