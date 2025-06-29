import 'package:groceryhelper/core/smooth_dialogs/smooth_dialog.dart';
import 'package:flutter/material.dart';

class SmoothDialogConfirm extends SmoothDialog {
  final String title;
  final String message;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  SmoothDialogConfirm({
    required this.title,
    required this.message,
    required this.confirmButtonText,
    required this.cancelButtonText,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget buildContent(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              flex: 2,
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    onCancel?.call();
                    Navigator.of(context).pop(false);
                  },
                  child: Text(cancelButtonText),
                ),
                ElevatedButton(
                  onPressed: () {
                    onConfirm?.call();
                    Navigator.of(context).pop(true);
                  },
                  child: Text(confirmButtonText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
