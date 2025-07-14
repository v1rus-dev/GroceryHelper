import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/debug_tools/presentation/widgets/utils/debug_drawer.dart';
import 'package:groceryhelper/shared_ui/theme/bloc/theme_bloc.dart' as theme_bloc;
import 'package:groceryhelper/shared_ui/theme/app_theme.dart';
import 'package:groceryhelper/app/router/app_router.dart';

class GroceryHelperApp extends StatefulWidget {
  const GroceryHelperApp({super.key});

  @override
  State<GroceryHelperApp> createState() => _GroceryHelperAppState();
}

class _GroceryHelperAppState extends State<GroceryHelperApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isSystemDark = brightness == Brightness.dark;
    context.read<theme_bloc.ThemeBloc>().add(theme_bloc.SystemThemeChangedEvent(isSystemDark));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<theme_bloc.ThemeBloc, theme_bloc.ThemeState>(
      builder: (context, themeState) {
        // Конвертируем наш ThemeMode в системный ThemeMode
        ThemeMode flutterThemeMode;
        switch (themeState.themeMode) {
          case theme_bloc.ThemeMode.light:
            flutterThemeMode = ThemeMode.light;
            break;
          case theme_bloc.ThemeMode.dark:
            flutterThemeMode = ThemeMode.dark;
            break;
          case theme_bloc.ThemeMode.system:
            flutterThemeMode = ThemeMode.system;
            break;
        }

        return MaterialApp.router(
          routerConfig: appRouter,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: flutterThemeMode,
          builder: (context, child) {
            return Stack(
              children: [
                child ?? const SizedBox(),
                Builder(builder: (context) => const DebugDrawer()),
              ],
            );
          },
        );
      },
    );
  }
}
