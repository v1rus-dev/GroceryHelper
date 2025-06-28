import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/utils/validators/validation_error.dart';
import 'package:groceryhelper/core/utils/validators/validation_result.dart';

class ValidationRequirementsList extends StatefulWidget {
  final ValidationResult validationResult;
  final bool showRequirements;

  const ValidationRequirementsList({super.key, required this.validationResult, this.showRequirements = true});

  @override
  State<ValidationRequirementsList> createState() => _ValidationRequirementsListState();
}

class _ValidationRequirementsListState extends State<ValidationRequirementsList> with TickerProviderStateMixin {
  late Map<ValidationErrorType, AnimationController> _fadeControllers;
  late Map<ValidationErrorType, Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeControllers = {};
    _fadeAnimations = {};

    for (final requirement in widget.validationResult.requirements) {
      _fadeControllers[requirement] = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
      _fadeAnimations[requirement] = CurvedAnimation(parent: _fadeControllers[requirement]!, curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    for (final controller in _fadeControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(ValidationRequirementsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Проверяем изменения состояния для каждого требования
    for (final requirement in widget.validationResult.requirements) {
      final wasFixed = oldWidget.validationResult.fixedRequirements.contains(requirement);
      final isFixed = widget.validationResult.fixedRequirements.contains(requirement);

      if (isFixed && !wasFixed) {
        // Требование стало выполненным - анимируем fade
        _fadeControllers[requirement]?.forward();
      } else if (!isFixed && wasFixed) {
        // Требование стало невыполненным - возвращаем fade назад
        _fadeControllers[requirement]?.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showRequirements || widget.validationResult.requirements.isEmpty || widget.validationResult.isValid) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.validationResult.requirements.map((requirementType) {
          final isFixed = widget.validationResult.fixedRequirements.contains(requirementType);
          final requirementText = widget.validationResult.getRequirementText(requirementType);
          final fadeController = _fadeControllers[requirementType];
          final fadeAnimation = _fadeAnimations[requirementType];

          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                if (fadeController != null && fadeAnimation != null)
                  AnimatedBuilder(
                    animation: fadeAnimation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Warning иконка (исчезает при выполнении)
                          Opacity(
                            opacity: isFixed ? 1.0 - fadeAnimation.value : 1.0,
                            child: SvgPicture.asset(
                              AppAssets.icWarning,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                            ),
                          ),
                          // Check иконка (появляется при выполнении)
                          Opacity(
                            opacity: isFixed ? fadeAnimation.value : 0.0,
                            child: SvgPicture.asset(
                              AppAssets.icCheck,
                              width: 16,
                              height: 16,
                              colorFilter: ColorFilter.mode(Colors.green, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                else
                  SvgPicture.asset(
                    isFixed ? AppAssets.icCheck : AppAssets.icWarning,
                    width: 16,
                    height: 16,
                    colorFilter: ColorFilter.mode(isFixed ? Colors.green : Colors.red, BlendMode.srcIn),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    requirementText,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Nunito',
                      color: isFixed ? Colors.green : Colors.grey,
                      fontWeight: isFixed ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
