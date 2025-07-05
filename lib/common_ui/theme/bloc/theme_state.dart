part of 'theme_bloc.dart';

enum ThemeMode { light, dark, system }

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isDark;

  const ThemeState({required this.themeMode, required this.isDark});

  @override
  List<Object> get props => [themeMode, isDark];

  ThemeState copyWith({ThemeMode? themeMode, bool? isDark}) {
    return ThemeState(themeMode: themeMode ?? this.themeMode, isDark: isDark ?? this.isDark);
  }
}
