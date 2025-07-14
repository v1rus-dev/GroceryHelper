part of '../validators.dart';

/// Результат валидации для системы правил
class RuleValidationResult {
  final List<ValidationRules> rules;
  final List<ValidationRules> failedRules;
  final bool isValid;

  const RuleValidationResult({required this.rules, required this.failedRules, required this.isValid});

  factory RuleValidationResult.success(List<ValidationRules> rules) {
    return RuleValidationResult(rules: rules, failedRules: [], isValid: true);
  }

  factory RuleValidationResult.withErrors(List<ValidationRules> rules, List<ValidationRules> failedRules) {
    return RuleValidationResult(rules: rules, failedRules: failedRules, isValid: failedRules.isEmpty);
  }

  /// Возвращает выполненные правила
  List<ValidationRules> get passedRules {
    return rules.where((rule) => !failedRules.contains(rule)).toList();
  }

  /// Возвращает приоритетные правила для отображения
  List<ValidationRules> get prioritizedRules {
    // Если есть правило RequiredRule в неудачных, показываем только его
    if (failedRules.any((rule) => rule is RequiredRule)) {
      return failedRules.where((rule) => rule is RequiredRule).toList();
    }

    // Иначе показываем все неудачные правила
    return failedRules;
  }

  /// Проверяет, должно ли отображаться конкретное правило
  bool shouldShowRule(ValidationRules rule) {
    final prioritized = prioritizedRules;

    // Если правило в списке приоритетных, показываем его
    if (prioritized.contains(rule)) {
      return true;
    }

    // Если правило выполнено и нет других неудачных правил, не показываем
    if (passedRules.contains(rule) && failedRules.isEmpty) {
      return false;
    }

    // Если правило выполнено, но есть другие неудачные правила, показываем только приоритетные
    if (passedRules.contains(rule)) {
      return prioritized.contains(rule);
    }

    return false;
  }

  /// Получает текст ошибки для правила
  String getRuleErrorMessage(ValidationRules rule) {
    return rule.getErrorMessage();
  }

  /// Получает текст требования для правила
  String getRuleRequirementText(ValidationRules rule) {
    return rule.getRequirementText();
  }
}
