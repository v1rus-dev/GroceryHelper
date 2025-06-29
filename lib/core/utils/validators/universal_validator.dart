import 'rules/validation_rules.dart';
import 'utils/rule_validation_result.dart';

/// Универсальный валидатор, который принимает список правил для проверки
class UniversalValidator {
  final List<ValidationRules> rules;
  bool _hasValidated = false;

  UniversalValidator(this.rules);

  bool get hasValidated => _hasValidated;

  /// Валидирует значение согласно заданным правилам
  RuleValidationResult validate(String? value) {
    if (!_hasValidated) {
      return RuleValidationResult.success(rules);
    }

    final List<ValidationRules> failedRules = [];

    // Если поле пустое, проверяем только RequiredRule
    if (value == null || value.isEmpty) {
      final requiredRule = rules.whereType<RequiredRule>().firstOrNull;
      if (requiredRule != null) {
        failedRules.add(requiredRule);
      }
    } else {
      // Если поле не пустое, проверяем все правила
      for (final rule in rules) {
        if (!rule.validate(value)) {
          failedRules.add(rule);
        }
      }
    }

    return RuleValidationResult.withErrors(rules, failedRules);
  }

  /// Начинает валидацию
  void startValidation() {
    _hasValidated = true;
  }

  /// Сбрасывает состояние валидации
  void reset() {
    _hasValidated = false;
  }
}
