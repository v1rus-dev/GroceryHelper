import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_dimens.dart';

/// Переход между диалогами с анимацией
class AnimatedDialogTransition extends StatefulWidget {
  final Widget fromDialog;
  final Widget toDialog;

  const AnimatedDialogTransition({super.key, required this.fromDialog, required this.toDialog});

  @override
  State<AnimatedDialogTransition> createState() => _AnimatedDialogTransitionState();
}

class _AnimatedDialogTransitionState extends State<AnimatedDialogTransition> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<BorderRadius?> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(AppDimens.radiusM),
      end: BorderRadius.circular(AppDimens.radiusL),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            child: Stack(
              children: [
                // Старый диалог (исчезает)
                Opacity(opacity: 1.0 - _fadeAnimation.value, child: widget.fromDialog),
                // Новый диалог (появляется)
                Opacity(opacity: _fadeAnimation.value, child: widget.toDialog),
              ],
            ),
          ),
        );
      },
    );
  }
}
