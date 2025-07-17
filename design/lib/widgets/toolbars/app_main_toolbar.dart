import 'package:design/widgets/buttons/empty_toolbar_button.dart';
import 'package:flutter/material.dart';
import 'package:design/design.dart';

class AppMainToolbar extends StatelessWidget implements PreferredSizeWidget {
  const AppMainToolbar({
    super.key,
    this.title,
    this.child,
    this.showGroceryHelperTitle = false,
    this.trailingWidget,
    this.onTrailingTap,
  }) : assert(
         title != null || child != null || showGroceryHelperTitle == true,
         'Необходимо передать либо title, либо child, либо установить showGroceryHelperTitle = true',
       );

  final String? title;
  final Widget? child;
  final bool showGroceryHelperTitle;
  final Widget? trailingWidget;
  final VoidCallback? onTrailingTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
        child: Row(
          children: [
            Expanded(child: child ?? _buildTitle(context)),
            if (trailingWidget != null) ...[
              const SizedBox(width: 20),
              GestureDetector(onTap: onTrailingTap, child: trailingWidget!),
            ] else ...[
              const SizedBox(width: 20),
              const EmptyToolbarButton(),
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

    return Text(title!, style: AppTextStyles.headline1.copyWith(color: theme.colorScheme.onSurface));
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
