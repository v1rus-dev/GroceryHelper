import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/common_ui/theme/app_text_styles.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';

class SignInWithApple extends StatelessWidget {
  const SignInWithApple({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: Material(
        color: context.theme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: context.theme.text, width: 1),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.appleLogo,
                  colorFilter: ColorFilter.mode(context.theme.text, BlendMode.srcIn),
                ),
                const Gap(8),
                Text('Продолжить с Apple', style: AppTextStyles.button.copyWith(color: context.theme.text)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
