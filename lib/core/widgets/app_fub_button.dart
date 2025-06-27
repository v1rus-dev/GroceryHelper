import 'package:flutter/material.dart';

class AppFubButton extends StatefulWidget {
  const AppFubButton({
    super.key,
    required this.onTap,
    required this.child,
    required this.color,
    this.width = 48,
    this.height = 48,
    this.borderRadius = 12,
  });

  final VoidCallback onTap;
  final Widget child;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;

  @override
  State<AppFubButton> createState() => _AppFubButtonState();
}

class _AppFubButtonState extends State<AppFubButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _isPressed ? 0.95 : 1.0,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(offset: const Offset(0, 4), blurRadius: 2, color: widget.color.withValues(alpha: 0.25)),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: InkWell(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              onTap: widget.onTap,
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              child: Center(child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}
