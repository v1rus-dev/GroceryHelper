import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/base_dialog.dart';

/// Диалог загрузки без текста
class LoadingDialog extends BaseDialog {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  @override
  Widget buildContent(BuildContext context) {
    return const SizedBox.shrink(); // Не используется в этом диалоге
  }
}
