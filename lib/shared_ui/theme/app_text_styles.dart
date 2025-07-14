import 'package:flutter/material.dart';

class AppTextStyles {
  // Базовые стили без цвета (цвет будет добавляться динамически)
  static const TextStyle _headline1Base = TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Nunito');

  static const TextStyle _headline2Base = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Nunito');

  static const TextStyle _bodyBase = TextStyle(fontSize: 16, fontFamily: 'Nunito', fontWeight: FontWeight.normal);

  static const TextStyle _bodySmallBase = TextStyle(fontSize: 14, fontFamily: 'Nunito', fontWeight: FontWeight.normal);

  static const TextStyle _buttonBase = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Nunito');
  static const TextStyle _mediumButtonBase = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'Nunito',
  );
  static const TextStyle _labelSmallBase = TextStyle(fontSize: 12, fontFamily: 'Nunito', fontWeight: FontWeight.normal);

  // Базовые стили без цвета
  static TextStyle get headline1 => _headline1Base;
  static TextStyle get headline2 => _headline2Base;
  static TextStyle get body => _bodyBase;
  static TextStyle get button => _buttonBase;

  // TextTheme для использования в ThemeData
  static const TextTheme textTheme = TextTheme(
    displayLarge: _headline1Base,
    displayMedium: _headline2Base,
    bodyMedium: _bodyBase,
    bodySmall: _bodySmallBase,
    labelLarge: _buttonBase,
    labelMedium: _mediumButtonBase,
    labelSmall: _labelSmallBase,
  );
}
