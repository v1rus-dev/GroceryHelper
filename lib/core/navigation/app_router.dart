import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/features/home/presentation/view/home_screen.dart';
import 'package:groceryhelper/features/settings/presentation/screens/settings_screen.dart';
import 'package:groceryhelper/features/register/presentation/screens/register_screen.dart';
import 'package:groceryhelper/features/shopping_list/presentation/screens/shopping_list.dart';
import 'package:groceryhelper/features/buskets/presentation/view/buskets_screen.dart';
import 'package:groceryhelper/features/user/presentation/screens/user_screen.dart';
import 'package:groceryhelper/features/root/root_screen.dart';
import 'package:groceryhelper/core/utils/debug/presentation/screens/debug_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter/widgets.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouterPaths.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return RootScreen(child: child);
      },
      routes: [
        GoRoute(
          path: RouterPaths.home,
          builder: (context, state) => HomeScreen(),
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: HomeScreen(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: RouterPaths.buskets,
          builder: (context, state) => BusketsScreen(),
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: BusketsScreen(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: RouterPaths.shoppingList,
          builder: (context, state) => ShoppingList(),
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ShoppingList(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
        GoRoute(
          path: RouterPaths.user,
          builder: (context, state) => UserScreen(),
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: UserScreen(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ],
    ),
    GoRoute(path: RouterPaths.register, builder: (context, state) => RegisterScreen()),
    GoRoute(path: RouterPaths.settings, builder: (context, state) => SettingsScreen()),
    GoRoute(
      path: RouterPaths.talker,
      builder: (context, state) => TalkerScreen(talker: TalkerService.instance),
    ),
    GoRoute(path: RouterPaths.debug, builder: (context, state) => const DebugScreen()),
  ],
);
