import 'validation_error.dart';
import 'validation_result.dart';

class PasswordValidator {
  bool _hasValidated = false;

  bool get hasValidated => _hasValidated;

  static const List<ValidationErrorType> _requirements = [
    ValidationErrorType.empty,
    ValidationErrorType.tooShort,
    ValidationErrorType.noLowercase,
    ValidationErrorType.noNumbers,
  ];

  ValidationResult validate(String? value) {
    if (!_hasValidated) {
      return ValidationResult.success();
    }

    final List<ValidationError> errors = [];

    if (value == null || value.isEmpty) {
      // Если пароль пустой, все требования не выполнены
      errors.add(const ValidationError(type: ValidationErrorType.empty, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.tooShort, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.noLowercase, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.noNumbers, isFixed: false));
    } else {
      // Проверяем каждое требование только если пароль не пустой
      if (value.length < 6) {
        errors.add(const ValidationError(type: ValidationErrorType.tooShort, isFixed: false));
      }
      if (!RegExp(r'[a-z]').hasMatch(value)) {
        errors.add(const ValidationError(type: ValidationErrorType.noLowercase, isFixed: false));
      }
      if (!RegExp(r'\d').hasMatch(value)) {
        errors.add(const ValidationError(type: ValidationErrorType.noNumbers, isFixed: false));
      }
    }

    return ValidationResult.withErrors(errors, _requirements);
  }

  void startValidation() {
    _hasValidated = true;
  }

  void reset() {
    _hasValidated = false;
  }
}
