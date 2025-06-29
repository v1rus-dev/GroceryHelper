import 'validation_rule.dart';

/// Sealed class для правил валидации
sealed class ValidationRules implements ValidationRule {
  const ValidationRules();

  @override
  bool validate(String? value);

  /// Возвращает текст ошибки для правила
  String getErrorMessage();

  /// Возвращает текст требования для правила
  String getRequirementText();
}

/// Поле обязательно для заполнения
class RequiredRule extends ValidationRules {
  const RequiredRule();

  @override
  bool validate(String? value) {
    return value != null && value.isNotEmpty;
  }

  @override
  String getErrorMessage() {
    return 'Поле обязательно';
  }

  @override
  String getRequirementText() {
    return 'Поле обязательно';
  }
}

/// Минимальная длина строки
class MinLengthRule extends ValidationRules {
  final int minLength;

  const MinLengthRule(this.minLength);

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return value.length >= minLength;
  }

  @override
  String getErrorMessage() {
    return 'Минимум $minLength символов';
  }

  @override
  String getRequirementText() {
    return 'Минимум $minLength символов';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MinLengthRule && other.minLength == minLength;
  }

  @override
  int get hashCode => minLength.hashCode;
}

/// Максимальная длина строки
class MaxLengthRule extends ValidationRules {
  final int maxLength;

  const MaxLengthRule(this.maxLength);

  @override
  bool validate(String? value) {
    if (value == null) return true; // Пустое значение не проверяется на максимальную длину
    return value.length <= maxLength;
  }

  @override
  String getErrorMessage() {
    return 'Максимум $maxLength символов';
  }

  @override
  String getRequirementText() {
    return 'Максимум $maxLength символов';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MaxLengthRule && other.maxLength == maxLength;
  }

  @override
  int get hashCode => maxLength.hashCode;
}

/// Проверка формата email
class EmailFormatRule extends ValidationRules {
  const EmailFormatRule();

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return 'Неверный формат email';
  }

  @override
  String getRequirementText() {
    return 'Корректный email';
  }
}

/// Наличие заглавных букв
class UppercaseRule extends ValidationRules {
  const UppercaseRule();

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'[A-Z]').hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return 'Нет заглавных букв';
  }

  @override
  String getRequirementText() {
    return 'Заглавные буквы';
  }
}

/// Наличие строчных букв
class LowercaseRule extends ValidationRules {
  const LowercaseRule();

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'[a-z]').hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return 'Нет строчных букв';
  }

  @override
  String getRequirementText() {
    return 'Строчные буквы';
  }
}

/// Наличие цифр
class NumbersRule extends ValidationRules {
  const NumbersRule();

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'\d').hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return 'Нет цифр';
  }

  @override
  String getRequirementText() {
    return 'Цифры';
  }
}

/// Наличие специальных символов
class SpecialCharsRule extends ValidationRules {
  const SpecialCharsRule();

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return 'Нет спецсимволов';
  }

  @override
  String getRequirementText() {
    return 'Спецсимволы';
  }
}

/// Совпадение паролей
class PasswordMatchRule extends ValidationRules {
  final String passwordToMatch;

  const PasswordMatchRule(this.passwordToMatch);

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return value == passwordToMatch;
  }

  @override
  String getErrorMessage() {
    return 'Пароли не совпадают';
  }

  @override
  String getRequirementText() {
    return 'Пароли совпадают';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PasswordMatchRule && other.passwordToMatch == passwordToMatch;
  }

  @override
  int get hashCode => passwordToMatch.hashCode;
}

/// Пользовательское правило с регулярным выражением
class CustomRegexRule extends ValidationRules {
  final RegExp regex;
  final String errorMessage;
  final String requirementText;

  const CustomRegexRule(this.regex, this.errorMessage, this.requirementText);

  @override
  bool validate(String? value) {
    if (value == null || value.isEmpty) return false;
    return regex.hasMatch(value);
  }

  @override
  String getErrorMessage() {
    return errorMessage;
  }

  @override
  String getRequirementText() {
    return requirementText;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CustomRegexRule &&
        other.regex.pattern == regex.pattern &&
        other.errorMessage == errorMessage &&
        other.requirementText == requirementText;
  }

  @override
  int get hashCode => regex.pattern.hashCode ^ errorMessage.hashCode ^ requirementText.hashCode;
}
