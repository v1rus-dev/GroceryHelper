import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({super.key, required this.label, required this.hintText, required this.onTap});

  final String? label;
  final String hintText;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: context.theme.textFieldBackground,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label ?? hintText,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    color: label != null ? context.theme.text : context.theme.secondaryText,
                    fontSize: 16,
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.icDropDown,
                  colorFilter: ColorFilter.mode(context.theme.secondaryText, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
