import 'package:flutter/material.dart';
import 'package:design/design.dart';

class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.usePressEffect = false,
    this.isDisabled = false,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final bool usePressEffect;
  final bool isDisabled;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.isDisabled
        ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : (widget.color ?? theme.colorScheme.primary);
    final textColor = widget.isDisabled ? theme.colorScheme.onSurfaceVariant : theme.colorScheme.onPrimary;

    Widget buttonContent = SizedBox(
      height: 56,
      width: double.infinity,
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.isDisabled ? null : widget.onPressed,
          onTapDown: (widget.usePressEffect && !widget.isDisabled) ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: (widget.usePressEffect && !widget.isDisabled) ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: (widget.usePressEffect && !widget.isDisabled) ? () => setState(() => _isPressed = false) : null,
          child: Center(
            child: Text(widget.text, style: AppTextStyles.button.copyWith(color: textColor)),
          ),
        ),
      ),
    );

    if (widget.usePressEffect && !widget.isDisabled) {
      return Transform.translate(offset: Offset(0, _isPressed ? 2 : 0), child: buttonContent);
    }

    return buttonContent;
  }
}
