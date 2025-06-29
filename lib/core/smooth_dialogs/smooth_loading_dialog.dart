import 'package:flutter/material.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dialog.dart';

class SmoothLoadingDialog extends SmoothDialog {
  final String? text;

  bool get isSmall => text == null;

  SmoothLoadingDialog({this.text});

  @override
  Widget buildContent(BuildContext context) {
    if (text != null) {
      // Диалог с текстом - контент помещается в 200x120
      return Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                text!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      );
    }

    // Обычный диалог - контент помещается в 200x80
    return SizedBox(width: 80, height: 80, child: const Center(child: CircularProgressIndicator()));
  }

  @override
  double get width => isSmall ? 80 : 200;

  @override
  double get height => 80;
}
