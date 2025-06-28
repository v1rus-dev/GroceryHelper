import 'package:flutter/material.dart';
import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groceryhelper/core/theme/app_theme_extension.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class AppToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppToolbar({super.key, required this.title, this.withBackButton = false, this.onBackPressed});

  final String title;
  final bool withBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              if (withBackButton) ...[
                IconButton(
                  onPressed: onBackPressed ?? () => appRouter.pop(),
                  icon: SvgPicture.asset(
                    AppAssets.icArrowBack,
                    colorFilter: ColorFilter.mode(context.textColor, BlendMode.srcIn),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.fromLTRB(withBackButton ? 4 : 20, 0, 20, 0),
                child: Text(title, style: AppTextStyles.headline2.copyWith(color: context.textColor)),
              ),
            ],
          ),
        ),
        Divider(color: context.dividerColor, height: 1, thickness: 1),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(61);
}
