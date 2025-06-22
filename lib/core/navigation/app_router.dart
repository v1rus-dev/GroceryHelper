import 'package:cookmatch/core/navigation/router_paths.dart';
import 'package:cookmatch/features/auth/login/presentation/screens/login_screen.dart';
import 'package:cookmatch/features/auth/user/presentation/screens/user_screen.dart';
import 'package:cookmatch/features/home/home_screen.dart';
import 'package:cookmatch/features/recipes/presentation/screens/recipes_screen.dart';
import 'package:cookmatch/features/shopping_list/presentation/screens/shopping_list.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
