import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';

/// Базовый класс для всех диалогов с общими стилями
abstract class BaseDialog extends StatelessWidget {
  const BaseDialog({super.key});

  /// Минимальная ширина диалога
  double get minWidth => 200.0;

  /// Максимальная ширина диалога
  double get maxWidth => 400.0;

  /// Радиус закругления диалога
  double get borderRadius => AppDimens.radiusM;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth, maxWidth: maxWidth),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: buildContent(context),
      ),
    );
  }

  Widget buildContent(BuildContext context);
}
