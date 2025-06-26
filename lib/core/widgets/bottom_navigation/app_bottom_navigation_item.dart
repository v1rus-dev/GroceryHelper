import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigationItemModel {
  const AppBottomNavigationItemModel({required this.icon, this.selectedColor = const Color(0xFF2D264B)});
  final String icon;
  final Color selectedColor;
}

class AppBottomNavigationItem extends StatefulWidget {
  const AppBottomNavigationItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedColor = const Color(0xFF2D264B),
  });

  final String icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;

  @override
  State<AppBottomNavigationItem> createState() => _AppBottomNavigationItemState();
}

class _AppBottomNavigationItemState extends State<AppBottomNavigationItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap,
          child: Container(
            height: 40,
            child: Center(
              child: SvgPicture.asset(
                widget.icon,
                width: 24,
                height: 24,
                colorFilter: widget.isSelected ? ColorFilter.mode(widget.selectedColor, BlendMode.srcIn) : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
