import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BasketIcon extends StatelessWidget {
  const BasketIcon({
    super.key,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.package,
    this.onTap,
  });

  final Color backgroundColor;
  final Color iconColor;
  final String icon;
  final String package;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            icon,
            package: package,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
