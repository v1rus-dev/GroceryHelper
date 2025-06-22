import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/features/auth/login/presentation/screens/login_screen.dart';
import 'package:groceryhelper/features/auth/user/presentation/screens/user_screen.dart';
import 'package:groceryhelper/features/home/home_screen.dart';
import 'package:groceryhelper/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:groceryhelper/features/shopping_list/presentation/screens/shopping_list.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouterPaths.recipes,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(child: child);
      },
      routes: [
        GoRoute(
          path: RouterPaths.recipes,
          builder: (context, state) => RecipesScreen(),
        ),
        GoRoute(
          path: RouterPaths.shoppingList,
          builder: (context, state) => ShoppingList(),
        ),
        GoRoute(
          path: RouterPaths.user,
          builder: (context, state) => UserScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RouterPaths.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RouterPaths.talker,
      builder: (context, state) => TalkerScreen(talker: TalkerService.instance),
    ),
  ],
);
