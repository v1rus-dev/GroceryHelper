import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:groceryhelper/core/widgets/bottom_navigation/app_bottom_navigation.dart';
import 'package:groceryhelper/core/widgets/bottom_navigation/app_bottom_navigation_item.dart';
import 'package:groceryhelper/core/services/navigation_state_service.dart';

class RootScreen extends StatefulWidget {
  final Widget child;
  const RootScreen({required this.child, super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Инициализируем индекс из сервиса
    _currentIndex = NavigationStateService.instance.lastKnownIndex;
    // Инициализируем индекс при создании виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateCurrentIndex();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Обновляем индекс при изменении состояния приложения
    if (state == AppLifecycleState.resumed) {
      _updateCurrentIndex();
    }
  }

  void _updateCurrentIndex() {
    final newIndex = _calculateSelectedIndex(context);
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
      // Сохраняем текущий индекс в сервисе
      NavigationStateService.instance.setLastKnownIndex(newIndex);
    }
  }

  int _calculateSelectedIndex(BuildContext context) {
    final path = GoRouter.of(context).state.path;
    final extra = GoRouter.of(context).state.extra;

    // Добавляем отладочную информацию
    if (path != null) {
      debugPrint('RootScreen: Current path = $path, current index = $_currentIndex, extra = $extra');
    }

    // Проверяем, находимся ли мы на одном из основных экранов
    if (path?.startsWith(RouterPaths.home) == true) return 0;
    if (path?.startsWith(RouterPaths.buskets) == true) return 1;
    if (path?.startsWith(RouterPaths.shoppingList) == true) return 2;
    if (path?.startsWith(RouterPaths.user) == true) return 3;

    // Если путь пустой, null или не соответствует основным экранам,
    // возвращаем последний известный индекс из сервиса
    if (path == null || path.isEmpty) {
      final lastKnownIndex = NavigationStateService.instance.lastKnownIndex;
      debugPrint('RootScreen: Path is null or empty, using last known index: $lastKnownIndex');
      return lastKnownIndex;
    }

    // Если путь не соответствует основным экранам, возвращаем последний известный индекс
    final lastKnownIndex = NavigationStateService.instance.lastKnownIndex;
    debugPrint('RootScreen: Path $path does not match any main screens, using last known index: $lastKnownIndex');
    return lastKnownIndex;
  }

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _currentIndex = index;
    });
    // Сохраняем индекс в сервисе при нажатии
    NavigationStateService.instance.setLastKnownIndex(index);

    switch (index) {
      case 0:
        context.go(RouterPaths.home);
        break;
      case 1:
        context.go(RouterPaths.buskets);
        break;
      case 2:
        context.go(RouterPaths.shoppingList);
        break;
      case 3:
        context.go(RouterPaths.user);
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Обновляем индекс при изменении зависимостей (включая роутер)
    _updateCurrentIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: SafeArea(
        child: AppBottomNavigation(
          items: [
            AppBottomNavigationItemModel(icon: AppAssets.navHome),
            AppBottomNavigationItemModel(icon: AppAssets.navBusket),
            AppBottomNavigationItemModel(icon: AppAssets.navProducts),
            AppBottomNavigationItemModel(icon: AppAssets.navProfile),
          ],
          onTap: (index) {
            _onItemTapped(context, index);
          },
          currentIndex: _currentIndex,
        ),
      ),
    );
  }
}
