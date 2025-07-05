import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/common_ui/theme/bloc/theme_bloc.dart' as theme_bloc;

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<theme_bloc.ThemeBloc, theme_bloc.ThemeState>(
      builder: (context, state) {
        // Если системная тема, показываем иконку противоположной темы
        if (state.themeMode == theme_bloc.ThemeMode.system) {
          return Stack(
            children: [
              // Основная иконка (противоположная текущей системной теме)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      // При нажатии отключаем системную тему и ставим противоположную
                      final oppositeTheme = state.isDark ? theme_bloc.ThemeMode.light : theme_bloc.ThemeMode.dark;
                      context.read<theme_bloc.ThemeBloc>().add(theme_bloc.ThemeSetEvent(oppositeTheme));
                    },
                    child: Center(
                      child: SvgPicture.asset(
                        // Показываем иконку противоположной темы
                        state.isDark ? AppAssets.icThemeLight : AppAssets.icThemeDark,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
              // Красный индикатор системной темы
              Positioned(
                top: 2,
                right: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.6), blurRadius: 4, spreadRadius: 1)],
                  ),
                ),
              ),
            ],
          );
        }

        // Если не системная тема, обычное переключение между светлой и темной
        String iconPath = state.themeMode == theme_bloc.ThemeMode.light
            ? AppAssets.icThemeDark
            : AppAssets.icThemeLight;

        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                final newTheme = state.themeMode == theme_bloc.ThemeMode.light
                    ? theme_bloc.ThemeMode.dark
                    : theme_bloc.ThemeMode.light;
                context.read<theme_bloc.ThemeBloc>().add(theme_bloc.ThemeSetEvent(newTheme));
              },
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
