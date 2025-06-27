part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

final class ThemeInitEvent extends ThemeEvent {}

final class ThemeToggleEvent extends ThemeEvent {}

final class ThemeSetEvent extends ThemeEvent {
  final ThemeMode themeMode;

  const ThemeSetEvent(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}

final class SystemThemeChangedEvent extends ThemeEvent {
  final bool isSystemDark;

  const SystemThemeChangedEvent(this.isSystemDark);

  @override
  List<Object> get props => [isSystemDark];
}
