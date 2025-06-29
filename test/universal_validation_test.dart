import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/core/utils/validators/universal_validator.dart';
import 'package:groceryhelper/core/utils/validators/rules/validation_rules.dart';
import 'package:groceryhelper/core/utils/validators/utils/rule_validation_result.dart';

void main() {
  group('UniversalValidator Tests', () {
    test('should validate required field correctly', () {
      final validator = UniversalValidator([const RequiredRule()]);
      validator.startValidation();

      // Пустое поле
      var result = validator.validate('');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<RequiredRule>());

      // Непустое поле
      result = validator.validate('test');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });

    test('should validate min length correctly', () {
      final validator = UniversalValidator([const MinLengthRule(5)]);
      validator.startValidation();

      // Слишком короткое
      var result = validator.validate('test');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<MinLengthRule>());

      // Достаточная длина
      result = validator.validate('testing');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });

    test('should validate max length correctly', () {
      final validator = UniversalValidator([const MaxLengthRule(5)]);
      validator.startValidation();

      // Слишком длинное
      var result = validator.validate('testing');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<MaxLengthRule>());

      // Подходящая длина
      result = validator.validate('test');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });

    test('should validate email format correctly', () {
      final validator = UniversalValidator([const EmailFormatRule()]);
      validator.startValidation();

      // Неверный формат
      var result = validator.validate('invalid-email');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<EmailFormatRule>());

      // Верный формат
      result = validator.validate('test@example.com');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });

    test('should validate multiple rules correctly', () {
      final validator = UniversalValidator([const RequiredRule(), const MinLengthRule(5), const UppercaseRule()]);
      validator.startValidation();

      // Пустое поле - только RequiredRule должно быть в ошибках
      var result = validator.validate('');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<RequiredRule>());

      // Короткое поле без заглавных букв
      result = validator.validate('test');
      expect(result.isValid, false);
      expect(result.failedRules.length, 2);
      expect(result.failedRules.any((rule) => rule is MinLengthRule), true);
      expect(result.failedRules.any((rule) => rule is UppercaseRule), true);

      // Все правила выполнены
      result = validator.validate('TESTING');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });

    test('should validate password match correctly', () {
      final validator = UniversalValidator([const RequiredRule(), PasswordMatchRule('password123')]);
      validator.startValidation();

      // Несовпадение
      var result = validator.validate('different');
      expect(result.isValid, false);
      expect(result.failedRules.length, 1);
      expect(result.failedRules.first, isA<PasswordMatchRule>());

      // Совпадение
      result = validator.validate('password123');
      expect(result.isValid, true);
      expect(result.failedRules.isEmpty, true);
    });
  });

  group('RuleValidationResult Priority Tests', () {
    test('should prioritize required rule when field is empty', () {
      final result = RuleValidationResult.withErrors(
        [const RequiredRule(), const MinLengthRule(5), const UppercaseRule()],
        [const RequiredRule()],
      );

      expect(result.prioritizedRules, [const RequiredRule()]);
      expect(result.shouldShowRule(const RequiredRule()), true);
      expect(result.shouldShowRule(const MinLengthRule(5)), false);
      expect(result.shouldShowRule(const UppercaseRule()), false);
    });

    test('should show all failed rules when field is not empty', () {
      final result = RuleValidationResult.withErrors(
        [const RequiredRule(), const MinLengthRule(5), const UppercaseRule()],
        [const MinLengthRule(5), const UppercaseRule()],
      );

      expect(result.prioritizedRules.length, 2);
      expect(result.shouldShowRule(const RequiredRule()), false);
      expect(result.shouldShowRule(const MinLengthRule(5)), true);
      expect(result.shouldShowRule(const UppercaseRule()), true);
    });

    test('should get correct requirement text for rules', () {
      final result = RuleValidationResult.success([
        const MinLengthRule(8),
        const MaxLengthRule(50),
        const EmailFormatRule(),
      ]);

      expect(result.getRuleRequirementText(const MinLengthRule(8)), 'Минимум 8 символов');
      expect(result.getRuleRequirementText(const MaxLengthRule(50)), 'Максимум 50 символов');
      expect(result.getRuleRequirementText(const EmailFormatRule()), 'Корректный email');
    });
  });
}
