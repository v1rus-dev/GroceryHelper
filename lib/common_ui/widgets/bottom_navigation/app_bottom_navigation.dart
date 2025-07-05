import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceryhelper/common_ui/widgets/bottom_navigation/app_bottom_navigation_item.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';

class AppBottomNavigation extends StatefulWidget {
  const AppBottomNavigation({super.key, required this.items, required this.onTap, required this.currentIndex});

  final int currentIndex;
  final Function(int) onTap;
  final List<AppBottomNavigationItemModel> items;

  @override
  State<AppBottomNavigation> createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<AppBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: context.theme.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return AppBottomNavigationItem(
                icon: item.icon,
                isSelected: index == widget.currentIndex,
                onTap: () {
                  widget.onTap(index);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
