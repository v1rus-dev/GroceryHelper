import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';

class AppButton extends StatefulWidget {
  const AppButton({super.key, required this.onPressed, required this.text, this.color, this.usePressEffect = false});

  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final bool usePressEffect;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = widget.color ?? theme.colorScheme.primary;

    Widget buttonContent = SizedBox(
      height: 56,
      width: double.infinity,
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onPressed,
          onTapDown: widget.usePressEffect ? (_) => setState(() => _isPressed = true) : null,
          onTapUp: widget.usePressEffect ? (_) => setState(() => _isPressed = false) : null,
          onTapCancel: widget.usePressEffect ? () => setState(() => _isPressed = false) : null,
          child: Center(
            child: Text(widget.text, style: AppTextStyles.button.copyWith(color: theme.colorScheme.onPrimary)),
          ),
        ),
      ),
    );

    if (widget.usePressEffect) {
      return Transform.translate(offset: Offset(0, _isPressed ? 2 : 0), child: buttonContent);
    }

    return buttonContent;
  }
}
