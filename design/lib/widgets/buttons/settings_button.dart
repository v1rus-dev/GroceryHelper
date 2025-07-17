import 'package:design/constants/design_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsButton extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? iconSize;

  const SettingsButton({super.key, this.onTap, this.width, this.height, this.iconSize});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: width ?? 40,
      height: height ?? 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular((width ?? 40) / 2),
          onTap: onTap,
          child: Center(
            child: SvgPicture.asset(
              DesignAssets.icSettings,
              package: DesignAssets.packageName,
              width: iconSize ?? 24,
              height: iconSize ?? 24,
              colorFilter: ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
