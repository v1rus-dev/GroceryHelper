import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/base_dialog.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

/// Диалог с кнопками подтверждения и отмены
class ConfirmCancelDialog extends BaseDialog {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;

  const ConfirmCancelDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.cancelButtonText,
  });

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
          Row(
            children: [
              Expanded(
                child: OutlinedButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelButtonText)),
              ),
              const SizedBox(width: AppDimens.paddingM),
              Expanded(
                child: ElevatedButton(onPressed: () => Navigator.of(context).pop(true), child: Text(confirmButtonText)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
