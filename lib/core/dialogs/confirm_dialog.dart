import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/base_dialog.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

/// Диалог с одной кнопкой подтверждения
class ConfirmDialog extends BaseDialog {
  final String title;
  final String message;
  final String confirmButtonText;

  const ConfirmDialog({super.key, required this.title, required this.message, required this.confirmButtonText});

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headline2.copyWith(color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: AppDimens.paddingM),
          Text(message, style: AppTextStyles.body.copyWith(color: Theme.of(context).colorScheme.onSurface)),
          const SizedBox(height: AppDimens.paddingL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: Text(confirmButtonText)),
          ),
        ],
      ),
    );
  }
}
