import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceryhelper/core/widgets/bottom_navigation/app_bottom_navigation_item.dart';

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
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ...widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Expanded(
                child: AppBottomNavigationItem(
                  icon: item.icon,
                  isSelected: index == widget.currentIndex,
                  onTap: () {
                    widget.onTap(index);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
