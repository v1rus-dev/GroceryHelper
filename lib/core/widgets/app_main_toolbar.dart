import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class AppMainToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppMainToolbar({
    super.key,
    this.text,
    this.child,
    this.showGroceryHelperTitle = false,
    this.trailingWidget,
    this.onTrailingTap,
  }) : assert(
         text != null || child != null || showGroceryHelperTitle == true,
         'Необходимо передать либо text, либо child, либо установить showGroceryHelperTitle = true',
       );

  final String? text;
  final Widget? child;
  final bool showGroceryHelperTitle;
  final Widget? trailingWidget;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 16, trailingWidget != null ? 12 : 20, 0),
        child: Row(
          children: [
            Expanded(child: child ?? _buildTitle(context)),
            if (trailingWidget != null) ...[
              const SizedBox(width: 20),
              GestureDetector(onTap: onTrailingTap, child: trailingWidget!),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);

    if (showGroceryHelperTitle) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Grocery',
              style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.primary),
            ),
            TextSpan(
              text: 'Helper',
              style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    return Text(text!, style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.onSurface));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
