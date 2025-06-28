import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/theme/app_theme_extension.dart';
import 'package:groceryhelper/core/utils/validators/validation_result.dart';
import 'validation_requirements_list.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.leadingIcon,
    this.isPassword = false,
    this.validationResult,
    this.showRequirements = true,
    this.focusNode,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? leadingIcon;
  final bool isPassword;
  final ValidationResult? validationResult;
  final bool showRequirements;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> with TickerProviderStateMixin {
  bool _obscureText = false;
  bool _hasFocus = false;
  bool _shouldShowRequirements = false;

  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText || widget.isPassword;

    // Анимация для иконок
    _iconAnimationController = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _iconAnimation = CurvedAnimation(parent: _iconAnimationController, curve: Curves.easeInOut);

    // Инициализируем состояние анимации
    _updateRequirementsVisibility();
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });

    // Анимация смены иконки
    _iconAnimationController.forward().then((_) {
      _iconAnimationController.reverse();
    });
  }

  void _updateRequirementsVisibility() {
    final hasRequirements = widget.validationResult != null && widget.validationResult!.requirements.isNotEmpty;

    setState(() {
      _shouldShowRequirements = hasRequirements;
    });
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateRequirementsVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFBDBDBD).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _hasFocus = hasFocus;
              });
            },
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: _obscureText,
              keyboardType: widget.isPassword ? TextInputType.visiblePassword : widget.keyboardType,
              textInputAction: widget.textInputAction,
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onSubmitted,
              validator: widget.validator,
              decoration: InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                prefixIcon: widget.leadingIcon != null
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                        child: SvgPicture.asset(
                          widget.leadingIcon!,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(context.secondaryTextColor, BlendMode.srcIn),
                        ),
                      )
                    : null,
                suffixIcon: widget.isPassword
                    ? AnimatedBuilder(
                        animation: _iconAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 0.8 + (_iconAnimation.value * 0.2),
                            child: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: SvgPicture.asset(
                                _obscureText ? AppAssets.icPasswordHide : AppAssets.icPasswordShow,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(context.secondaryTextColor, BlendMode.srcIn),
                              ),
                            ),
                          );
                        },
                      )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: context.primaryColor, width: 1),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                hintStyle: TextStyle(fontFamily: 'Nunito', color: context.secondaryTextColor, fontSize: 16),
                labelStyle: TextStyle(fontFamily: 'Nunito', color: context.secondaryTextColor, fontSize: 16),
                floatingLabelStyle: TextStyle(
                  fontFamily: 'Nunito',
                  color: _hasFocus ? context.primaryColor : context.secondaryTextColor,
                  fontSize: 16,
                ),
              ),
              style: TextStyle(color: context.textColor, fontSize: 16),
            ),
          ),
        ),
        if (_shouldShowRequirements)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ValidationRequirementsList(
              validationResult: widget.validationResult!,
              showRequirements: widget.showRequirements,
            ),
          ),
      ],
    );
  }
}
