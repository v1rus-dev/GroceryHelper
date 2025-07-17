import 'package:design/constants/design_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:design/design.dart';

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
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: onBackPressed,
                      child: Center(
                        child: SvgPicture.asset(
                          DesignAssets.icArrowBack,
                          package: DesignAssets.packageName,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(context.theme.text, BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              Padding(
                padding: EdgeInsets.fromLTRB(withBackButton ? 4 : 20, 0, 20, 0),
                child: Text(title, style: AppTextStyles.headline2.copyWith(color: context.theme.text)),
              ),
            ],
          ),
        ),
        Divider(color: context.theme.divider, height: 1, thickness: 1),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(61);
}
