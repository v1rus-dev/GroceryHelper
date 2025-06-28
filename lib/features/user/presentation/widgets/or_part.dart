import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/theme/app_theme_extension.dart';

class OrPart extends StatelessWidget {
  const OrPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: context.dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('или', style: AppTextStyles.body.copyWith(color: context.secondaryTextColor)),
        ),
        Expanded(child: Divider(color: context.dividerColor)),
      ],
    );
  }
}
