import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/common_ui/theme/app_text_styles.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key, required this.onPressed});

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
          side: BorderSide(color: Color(0xFF4285F4), width: 1),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.googleLogo),
                const Gap(8),
                Text('Продолжить с Google', style: AppTextStyles.button.copyWith(color: Color(0xFF4285F4))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
