import 'package:design/constants/design_assets.dart';
import 'package:design/enums/app_theme_mode.dart';
import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_svg/flutter_svg.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key, required this.onTap, required this.themeMode});

  final VoidCallback onTap;
  final AppThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Если системная тема, показываем иконку противоположной темы
    if (themeMode == AppThemeMode.system) {
      return Stack(
        children: [
          // Основная иконка (противоположная текущей системной теме)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onTap,
                child: Center(
                  child: SvgPicture.asset(
                    // Показываем иконку противоположной темы
                    themeMode == AppThemeMode.light ? DesignAssets.icThemeLight : DesignAssets.icThemeDark,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
          // Красный индикатор системной темы
          Positioned(
            top: 2,
            right: 2,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.red.withValues(alpha: 0.6), blurRadius: 4, spreadRadius: 1)],
              ),
            ),
          ),
        ],
      );
    }

    // Если не системная тема, обычное переключение между светлой и темной
    String iconPath = themeMode == AppThemeMode.light ? DesignAssets.icThemeDark : DesignAssets.icThemeLight;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
