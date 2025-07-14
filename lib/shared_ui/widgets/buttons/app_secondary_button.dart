import 'package:flutter/material.dart';
import 'package:groceryhelper/shared_ui/theme/app_text_styles.dart';
import 'package:groceryhelper/shared_ui/theme/app_theme_extension.dart';

class AppSecondaryButton extends StatefulWidget {
  const AppSecondaryButton({
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
  State<AppSecondaryButton> createState() => _AppSecondaryButtonState();
}

class _AppSecondaryButtonState extends State<AppSecondaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color borderColor = widget.isDisabled ? context.theme.secondaryText : (widget.color ?? context.theme.primary);
    final Color textColor = widget.isDisabled ? context.theme.secondaryText : (widget.color ?? context.theme.primary);
    final Color backgroundColor = widget.isDisabled
        ? theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : Colors.transparent;

    Widget buttonContent = SizedBox(
      height: 56,
      width: double.infinity,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.isDisabled ? null : widget.onPressed,
          onTapDown: (widget.usePressEffect && !widget.isDisabled) ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: (widget.usePressEffect && !widget.isDisabled) ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: (widget.usePressEffect && !widget.isDisabled) ? () => setState(() => _isPressed = false) : null,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(widget.text, style: AppTextStyles.button.copyWith(color: textColor)),
            ),
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
