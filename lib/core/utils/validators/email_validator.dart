import 'validation_error.dart';
import 'validation_result.dart';

class EmailValidator {
  bool _hasValidated = false;

  bool get hasValidated => _hasValidated;

  static const List<ValidationErrorType> _requirements = [ValidationErrorType.empty, ValidationErrorType.invalidEmail];

  ValidationResult validate(String? value) {
    if (!_hasValidated) {
      return ValidationResult.success();
    }

    final List<ValidationError> errors = [];

    if (value == null || value.isEmpty) {
      // Если email пустой, все требования не выполнены
      errors.add(const ValidationError(type: ValidationErrorType.empty, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.invalidEmail, isFixed: false));
    } else {
      // Проверяем формат только если email не пустой
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value)) {
        errors.add(const ValidationError(type: ValidationErrorType.invalidEmail, isFixed: false));
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
