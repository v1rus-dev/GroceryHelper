import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/core/theme/app_theme.dart';
import 'package:groceryhelper/core/theme/app_theme_ios.dart';
import 'package:groceryhelper/core/theme/bloc/theme_bloc.dart' as theme_bloc;
import 'package:groceryhelper/core/utils/platform_type.dart';
import 'package:groceryhelper/core/widgets/debug_drawer.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';
import 'package:groceryhelper/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:groceryhelper/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем Talker
  if (kDebugMode) {
    TalkerService.init();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await initServiceLocator();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<HomeBloc>()),
        BlocProvider(create: (_) => locator<BusketsBloc>()),
        BlocProvider(create: (_) => locator<ShoppingListBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()..add(UserInitEvent())),
        BlocProvider(create: (_) => locator<theme_bloc.ThemeBloc>()..add(theme_bloc.ThemeInitEvent())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
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
                // Используем Builder, чтобы получить правильный context
                Builder(builder: (context) => const DebugDrawer()),
              ],
            );
          },
        );
      },
    );
  }
}
