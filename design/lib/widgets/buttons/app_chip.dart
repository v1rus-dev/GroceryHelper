import 'package:flutter/material.dart';
import 'package:design/design.dart';

@immutable
class AppChip extends StatefulWidget {
  const AppChip({
    super.key,
    required this.label,
    this.color,
    this.borderColor,
    this.isSelected = false,
    this.onTap,
    this.isDisabled = false,
  });

  final bool isSelected;
  final String label;
  final Color? color;
  final Color? borderColor;
  final bool? isDisabled;
  final VoidCallback? onTap;

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  Color _backgroundColor(BuildContext context) {
    if (widget.isSelected) {
      return widget.color?.withValues(alpha: 0.4) ?? context.theme.primary.withValues(alpha: 0.4);
    }
    return context.theme.background;
  }

  Color _borderColor(BuildContext context) {
    if (widget.borderColor != null) {
      return widget.borderColor!;
    }
    if (widget.isSelected) {
      return widget.color ?? context.theme.primary;
    }
    return context.theme.border;
  }

  Color _textColor(BuildContext context) {
    if (widget.isSelected) {
      return Colors.white;
    }
    return context.theme.secondaryText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: _backgroundColor(context),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _borderColor(context), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        enableFeedback: widget.onTap != null,
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(widget.label, style: theme.textTheme.bodySmall?.copyWith(color: _textColor(context))),
        ),
      ),
    );
  }
}
