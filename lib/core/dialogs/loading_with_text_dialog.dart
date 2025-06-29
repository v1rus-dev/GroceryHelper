import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/base_dialog.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

/// Диалог загрузки с текстом
class LoadingWithTextDialog extends BaseDialog {
  final String text;

  const LoadingWithTextDialog({super.key, required this.text});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(width: AppDimens.paddingM),
          Expanded(
            child: Text(text, style: AppTextStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface)),
          ),
        ],
      ),
    );
  }
}
