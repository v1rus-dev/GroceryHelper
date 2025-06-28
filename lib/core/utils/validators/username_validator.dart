import 'validation_error.dart';
import 'validation_result.dart';

class UsernameValidator {
  bool _hasValidated = false;

  bool get hasValidated => _hasValidated;

  static const List<ValidationErrorType> _requirements = [
    ValidationErrorType.empty,
    ValidationErrorType.tooShort,
    ValidationErrorType.tooLong,
  ];

  ValidationResult validate(String? value) {
    if (!_hasValidated) {
      return ValidationResult.success();
    }

    final List<ValidationError> errors = [];

    if (value == null || value.isEmpty) {
      errors.add(const ValidationError(type: ValidationErrorType.empty, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.tooShort, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.tooLong, isFixed: false));
    } else {
      if (value.length < 3) {
        errors.add(const ValidationError(type: ValidationErrorType.tooShort, isFixed: false));
      }
      if (value.length > 20) {
        errors.add(const ValidationError(type: ValidationErrorType.tooLong, isFixed: false));
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
