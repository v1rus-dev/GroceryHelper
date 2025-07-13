import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/navigation/app_router.dart';
import 'package:groceryhelper/infrastructure/services/database_service.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';
import 'package:groceryhelper/common_ui/theme/app_theme.dart';
import 'package:groceryhelper/common_ui/theme/bloc/theme_bloc.dart' as theme_bloc;
import 'package:groceryhelper/debug_tools/presentation/widgets/utils/debug_drawer.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:groceryhelper/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем Talker
  if (kDebugMode) {
    TalkerService.init();
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final database = AppDatabase();

  await initServiceLocator(database);

  locator<DatabaseService>().initializeDatabase();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: locator<HomeBloc>()),
        BlocProvider.value(value: locator<BusketsBloc>()),
        BlocProvider.value(value: locator<ProductsListBloc>()),
        BlocProvider.value(value: locator<UserBloc>()..add(UserInitEvent())),
        BlocProvider.value(value: locator<AuthBloc>()..add(AuthInitEvent())),
        BlocProvider.value(value: locator<theme_bloc.ThemeBloc>()..add(theme_bloc.ThemeInitEvent())),
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
                Builder(builder: (context) => const DebugDrawer()),
              ],
            );
          },
        );
      },
    );
  }
}
