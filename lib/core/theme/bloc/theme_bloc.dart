import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeModeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState(themeMode: ThemeMode.system, isDark: false)) {
    on<ThemeInitEvent>(_onInit);
    on<ThemeToggleEvent>(_onToggle);
    on<ThemeSetEvent>(_onSet);
    on<SystemThemeChangedEvent>(_onSystemThemeChanged);
  }

  Future<void> _onInit(ThemeInitEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    final themeMode = ThemeMode.values[themeModeIndex];

    // Определяем текущую системную тему
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isSystemDark = brightness == Brightness.dark;

    final isDark = _calculateIsDark(themeMode, isSystemDark);
    emit(ThemeState(themeMode: themeMode, isDark: isDark));
  }

  Future<void> _onToggle(ThemeToggleEvent event, Emitter<ThemeState> emit) async {
    ThemeMode newThemeMode;

    switch (state.themeMode) {
      case ThemeMode.light:
        newThemeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newThemeMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        newThemeMode = ThemeMode.light;
        break;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, newThemeMode.index);

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isSystemDark = brightness == Brightness.dark;
    final isDark = _calculateIsDark(newThemeMode, isSystemDark);

    emit(ThemeState(themeMode: newThemeMode, isDark: isDark));
  }

  Future<void> _onSet(ThemeSetEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, event.themeMode.index);

    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isSystemDark = brightness == Brightness.dark;
    final isDark = _calculateIsDark(event.themeMode, isSystemDark);

    emit(ThemeState(themeMode: event.themeMode, isDark: isDark));
  }

  void _onSystemThemeChanged(SystemThemeChangedEvent event, Emitter<ThemeState> emit) {
    if (state.themeMode == ThemeMode.system) {
      final isDark = _calculateIsDark(ThemeMode.system, event.isSystemDark);
      emit(ThemeState(themeMode: state.themeMode, isDark: isDark));
    }
  }

  bool _calculateIsDark(ThemeMode themeMode, bool isSystemDark) {
    switch (themeMode) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return isSystemDark;
    }
  }
}
