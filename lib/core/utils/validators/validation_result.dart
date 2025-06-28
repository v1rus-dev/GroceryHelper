import 'validation_error.dart';

class ValidationResult {
  final List<ValidationError> errors;
  final List<ValidationErrorType> requirements;
  final bool isValid;

  const ValidationResult({required this.errors, required this.requirements, required this.isValid});

  factory ValidationResult.success() {
    return const ValidationResult(errors: [], requirements: [], isValid: true);
  }

  factory ValidationResult.withErrors(List<ValidationError> errors, List<ValidationErrorType> requirements) {
    return ValidationResult(errors: errors, requirements: requirements, isValid: errors.isEmpty);
  }

  String? get firstErrorMessage {
    if (errors.isEmpty) return null;
    return _getErrorMessage(errors.first.type);
  }

  List<ValidationErrorType> get fixedRequirements {
    return requirements.where((req) {
      return !errors.any((error) => error.type == req);
    }).toList();
  }

  List<ValidationErrorType> get unfixedRequirements {
    return requirements.where((req) {
      return errors.any((error) => error.type == req);
    }).toList();
  }

  String _getErrorMessage(ValidationErrorType type) {
    switch (type) {
      case ValidationErrorType.empty:
        return 'Поле обязательно';
      case ValidationErrorType.tooShort:
        return 'Слишком короткое';
      case ValidationErrorType.tooLong:
        return 'Слишком длинное';
      case ValidationErrorType.invalidFormat:
        return 'Неверный формат';
      case ValidationErrorType.noUppercase:
        return 'Нет заглавных букв';
      case ValidationErrorType.noLowercase:
        return 'Нет строчных букв';
      case ValidationErrorType.noNumbers:
        return 'Нет цифр';
      case ValidationErrorType.noSpecialChars:
        return 'Нет спецсимволов';
      case ValidationErrorType.passwordsNotMatch:
        return 'Пароли не совпадают';
      case ValidationErrorType.invalidEmail:
        return 'Неверный email';
    }
  }

  String getRequirementText(ValidationErrorType type) {
    switch (type) {
      case ValidationErrorType.empty:
        return 'Поле обязательно';
      case ValidationErrorType.tooShort:
        return 'Минимум символов';
      case ValidationErrorType.tooLong:
        return 'Максимум символов';
      case ValidationErrorType.invalidFormat:
        return 'Правильный формат';
      case ValidationErrorType.noUppercase:
        return 'Заглавные буквы';
      case ValidationErrorType.noLowercase:
        return 'Строчные буквы';
      case ValidationErrorType.noNumbers:
        return 'Цифры';
      case ValidationErrorType.noSpecialChars:
        return 'Спецсимволы';
      case ValidationErrorType.passwordsNotMatch:
        return 'Пароли совпадают';
      case ValidationErrorType.invalidEmail:
        return 'Корректный email';
    }
  }
}
