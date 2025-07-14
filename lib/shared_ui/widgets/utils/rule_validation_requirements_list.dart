import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';
import 'package:groceryhelper/shared/validators/validators.dart';

class RuleValidationRequirementsList extends StatefulWidget {
  final RuleValidationResult validationResult;
  final bool showRequirements;

  const RuleValidationRequirementsList({super.key, required this.validationResult, this.showRequirements = true});

  @override
  State<RuleValidationRequirementsList> createState() => _RuleValidationRequirementsListState();
}

class _RuleValidationRequirementsListState extends State<RuleValidationRequirementsList> with TickerProviderStateMixin {
  late Map<ValidationRules, AnimationController> _fadeControllers;
  late Map<ValidationRules, Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeControllers = {};
    _fadeAnimations = {};

    // Инициализируем анимации только для правил, которые должны отображаться
    final visibleRules = widget.validationResult.rules
        .where((rule) => widget.validationResult.shouldShowRule(rule))
        .toList();

    for (final rule in visibleRules) {
      _fadeControllers[rule] = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
      _fadeAnimations[rule] = CurvedAnimation(parent: _fadeControllers[rule]!, curve: Curves.easeInOut);
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
  void didUpdateWidget(RuleValidationRequirementsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Получаем текущие и предыдущие видимые правила
    final currentVisibleRules = widget.validationResult.rules
        .where((rule) => widget.validationResult.shouldShowRule(rule))
        .toSet();

    final oldVisibleRules = oldWidget.validationResult.rules
        .where((rule) => oldWidget.validationResult.shouldShowRule(rule))
        .toSet();

    // Удаляем анимации для правил, которые больше не видимы
    final rulesToRemove = oldVisibleRules.difference(currentVisibleRules);
    for (final rule in rulesToRemove) {
      _fadeControllers[rule]?.dispose();
      _fadeControllers.remove(rule);
      _fadeAnimations.remove(rule);
    }

    // Добавляем анимации для новых видимых правил
    final rulesToAdd = currentVisibleRules.difference(oldVisibleRules);
    for (final rule in rulesToAdd) {
      _fadeControllers[rule] = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
      _fadeAnimations[rule] = CurvedAnimation(parent: _fadeControllers[rule]!, curve: Curves.easeInOut);
    }

    // Проверяем изменения состояния для каждого видимого правила
    for (final rule in currentVisibleRules) {
      final wasPassed = oldWidget.validationResult.passedRules.contains(rule);
      final isPassed = widget.validationResult.passedRules.contains(rule);

      if (isPassed && !wasPassed) {
        // Правило стало выполненным - анимируем fade
        _fadeControllers[rule]?.forward();
      } else if (!isPassed && wasPassed) {
        // Правило стало невыполненным - возвращаем fade назад
        _fadeControllers[rule]?.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.showRequirements || widget.validationResult.rules.isEmpty || widget.validationResult.isValid) {
      return const SizedBox.shrink();
    }

    // Фильтруем правила с учетом приоритизации
    final rulesToShow = widget.validationResult.rules
        .where((rule) => widget.validationResult.shouldShowRule(rule))
        .toList();

    if (rulesToShow.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rulesToShow.map((rule) {
        final isPassed = widget.validationResult.passedRules.contains(rule);
        final requirementText = widget.validationResult.getRuleErrorMessage(rule);
        final fadeController = _fadeControllers[rule];
        final fadeAnimation = _fadeAnimations[rule];

        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                          opacity: isPassed ? 1.0 - fadeAnimation.value : 1.0,
                          child: SvgPicture.asset(
                            AppAssets.icWarning,
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                          ),
                        ),
                        // Check иконка (появляется при выполнении)
                        Opacity(
                          opacity: isPassed ? fadeAnimation.value : 0.0,
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
                  isPassed ? AppAssets.icCheck : AppAssets.icWarning,
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(isPassed ? Colors.green : Colors.red, BlendMode.srcIn),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  requirementText,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Nunito',
                    color: isPassed ? Colors.green : Colors.grey,
                    fontWeight: isPassed ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
