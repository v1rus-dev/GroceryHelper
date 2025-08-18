import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimens.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
    ),
    primaryColor: AppColors.primaryLight,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    dialogTheme: DialogThemeData(backgroundColor: AppColors.background),
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
      hintStyle: TextStyle(fontFamily: 'Nunito'),
      labelStyle: TextStyle(fontFamily: 'Nunito'),
      floatingLabelStyle: TextStyle(fontFamily: 'Nunito'),
    ),
    extensions: [AppThemeColors.light],
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData get dark => ThemeData(
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
    ),
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTextStyles.textTheme,
    dialogTheme: DialogThemeData(backgroundColor: AppColors.darkBackground),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
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
      filled: true,
      fillColor: AppColors.darkDivider,
      hintStyle: TextStyle(fontFamily: 'Nunito'),
      labelStyle: TextStyle(fontFamily: 'Nunito'),
      floatingLabelStyle: TextStyle(fontFamily: 'Nunito'),
    ),
    extensions: [AppThemeColors.dark],
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static ThemeData getTheme(bool isDark) {
    return isDark ? dark : light;
  }
}

/// Кастомные цвета темы
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.text,
    required this.secondaryText,
    required this.divider,
    required this.border,
    required this.navigation,
    required this.basket,
    required this.primary,
    required this.textFieldBackground,
  });

  final Color background;
  final Color surface;
  final Color text;
  final Color secondaryText;
  final Color divider;
  final Color border;
  final Color navigation;
  final Color basket;
  final Color primary;
  final Color textFieldBackground;
  // Светлая тема
  static final light = AppThemeColors(
    background: AppColors.background,
    surface: AppColors.primaryBackground,
    text: AppColors.text,
    secondaryText: AppColors.secondaryText,
    divider: AppColors.divider,
    border: AppColors.border,
    navigation: AppColors.navigation,
    basket: AppColors.primaryBusketLight,
    primary: AppColors.primaryLight,
    textFieldBackground: AppColors.textFieldBackground,
  );

  // Темная тема
  static final dark = AppThemeColors(
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    text: AppColors.darkText,
    secondaryText: AppColors.darkSecondaryText,
    divider: AppColors.darkDivider,
    border: AppColors.darkBorder,
    navigation: AppColors.navigationDark,
    basket: AppColors.primaryBusketDark,
    primary: AppColors.primaryDark,
    textFieldBackground: AppColors.darkTextFieldBackground,
  );

  @override
  ThemeExtension<AppThemeColors> copyWith({
    Color? background,
    Color? surface,
    Color? text,
    Color? secondaryText,
    Color? divider,
    Color? border,
    Color? navigation,
    Color? busket,
    Color? primary,
    Color? textFieldBackground,
  }) {
    return AppThemeColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      secondaryText: secondaryText ?? this.secondaryText,
      divider: divider ?? this.divider,
      border: border ?? this.border,
      navigation: navigation ?? this.navigation,
      basket: busket ?? this.basket,
      primary: primary ?? this.primary,
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
    );
  }

  @override
  ThemeExtension<AppThemeColors> lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }
    return AppThemeColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      text: Color.lerp(text, other.text, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      border: Color.lerp(border, other.border, t)!,
      navigation: Color.lerp(navigation, other.navigation, t)!,
      basket: Color.lerp(basket, other.basket, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      textFieldBackground: Color.lerp(textFieldBackground, other.textFieldBackground, t)!,
    );
  }
}
