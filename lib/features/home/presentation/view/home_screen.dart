import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/shared_ui/theme/bloc/theme_bloc.dart';
import 'package:design/design.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  _onChangeTheme(BuildContext context, ThemeState state) {
    if (state.themeMode == AppThemeMode.system) {
      final oppositeTheme = state.isDark ? AppThemeMode.light : AppThemeMode.dark;
      context.read<ThemeBloc>().add(ThemeSetEvent(oppositeTheme));
    } else {
      final newTheme = state.themeMode == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
      context.read<ThemeBloc>().add(ThemeSetEvent(newTheme));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(
              showGroceryHelperTitle: true,
              trailingWidget: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  return SwitchThemeButton(
                    onTap: () {
                      _onChangeTheme(context, state);
                    },
                    themeMode: state.themeMode,
                  );
                },
              ),
            ),
            body: const Column(children: []),
          );
        },
      ),
    );
  }
}
