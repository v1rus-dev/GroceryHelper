import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/shared_ui/theme/app_theme_extension.dart';

class AppBottomNavigationItemModel {
  const AppBottomNavigationItemModel({required this.icon});
  final String icon;
}

class AppBottomNavigationItem extends StatefulWidget {
  const AppBottomNavigationItem({super.key, required this.icon, required this.isSelected, required this.onTap});

  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<AppBottomNavigationItem> createState() => _AppBottomNavigationItemState();
}

class _AppBottomNavigationItemState extends State<AppBottomNavigationItem> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _isPressed ? 0.95 : 1.0,
      child: SizedBox(
        width: 48,
        height: 48,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: widget.isSelected ? context.theme.navigation : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 2,
                      color: context.theme.navigation.withValues(alpha: 0.25),
                    ),
                  ]
                : null,
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: widget.onTap,
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset(
                    widget.icon,
                    key: ValueKey(widget.isSelected),
                    width: 24,
                    height: 24,
                    colorFilter: widget.isSelected
                        ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                        : ColorFilter.mode(context.theme.navigation, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
