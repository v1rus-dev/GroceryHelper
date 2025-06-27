import 'package:flutter/material.dart';

class AppColors {
  // Основной цвет
  static const Color primary = Color(0xFF0AB90A);

  // Оттенки primary цвета
  static final Color primaryLight = primary.withOpacity(0.8);
  static final Color primaryDark = primary.withOpacity(0.6);
  static final Color primaryBackground = primary.withOpacity(0.1);

  // Цвет навигации
  static const Color navigation = Color(0xFF2D264B);

  // Системные цвета
  static const Color background = Colors.white;
  static const Color accent = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color text = Color(0xFF212121);
  static const Color secondaryText = Color(0xFF757575);
}
