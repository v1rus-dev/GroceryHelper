import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/core/theme/app_theme.dart';
import 'package:groceryhelper/core/theme/app_theme_ios.dart';
import 'package:groceryhelper/core/utils/platform_type.dart';
import 'package:groceryhelper/core/widgets/debug_drawer.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/recipes/presentation/bloc/recipes_bloc.dart';
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
        BlocProvider(create: (_) => locator<RecipesBloc>()),
        BlocProvider(create: (_) => locator<ShoppingListBloc>()),
        BlocProvider(create: (_) => locator<UserBloc>()..add(UserInitEvent())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = PlatformType.isIOS ? AppThemeIOS.light : AppTheme.light;
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: theme,
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
  }
}
