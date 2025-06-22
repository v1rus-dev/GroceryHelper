import 'package:cookmatch/core/navigation/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({required this.child, super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final path = GoRouter.of(context).state.path;
    if (path?.startsWith(RouterPaths.recipes) == true) return 0;
    if (path?.startsWith(RouterPaths.shoppingList) == true) return 1;
    if (path?.startsWith(RouterPaths.user) == true) return 2;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouterPaths.recipes);
        break;
      case 1:
        context.go(RouterPaths.shoppingList);
      case 2:
        context.go(RouterPaths.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Рецепты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Покупки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Пользователь',
          ),
        ],
      ),
    );
  }
}
