import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:groceryhelper/core/widgets/bottom_navigation/app_bottom_navigation.dart';
import 'package:groceryhelper/core/widgets/bottom_navigation/app_bottom_navigation_item.dart';

class RootScreen extends StatelessWidget {
  final Widget child;
  const RootScreen({required this.child, super.key});

  int _calculateSelectedIndex(BuildContext context) {
    final path = GoRouter.of(context).state.path;
    if (path?.startsWith(RouterPaths.home) == true) return 0;
    if (path?.startsWith(RouterPaths.buskets) == true) return 1;
    if (path?.startsWith(RouterPaths.shoppingList) == true) return 2;
    if (path?.startsWith(RouterPaths.user) == true) return 3;
    return 0;
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouterPaths.home);
        break;
      case 1:
        context.go(RouterPaths.buskets);
      case 2:
        context.go(RouterPaths.shoppingList);
      case 3:
        context.go(RouterPaths.user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: SafeArea(
        child: AppBottomNavigation(
          items: const [
            AppBottomNavigationItemModel(icon: AppAssets.navHome),
            AppBottomNavigationItemModel(icon: AppAssets.navBusket),
            AppBottomNavigationItemModel(icon: AppAssets.navProducts),
            AppBottomNavigationItemModel(icon: AppAssets.navProfile),
          ],
          onTap: (index) {
            _onItemTapped(context, index);
          },
          currentIndex: selectedIndex,
        ),
      ),
    );
  }
}
