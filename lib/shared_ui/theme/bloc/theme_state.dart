part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final AppThemeMode themeMode;
  final bool isDark;

  const ThemeState({required this.themeMode, required this.isDark});

  @override
  List<Object> get props => [themeMode, isDark];

  ThemeState copyWith({AppThemeMode? themeMode, bool? isDark}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode, isDark: isDark ?? this.isDark);
  }
}
