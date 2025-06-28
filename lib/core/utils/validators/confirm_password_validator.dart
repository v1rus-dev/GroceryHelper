import 'validation_error.dart';
import 'validation_result.dart';

class ConfirmPasswordValidator {
  bool _hasValidated = false;

  bool get hasValidated => _hasValidated;

  static const List<ValidationErrorType> _requirements = [
    ValidationErrorType.empty,
    ValidationErrorType.passwordsNotMatch,
  ];

  ValidationResult validate(String? password, String? confirmPassword) {
    if (!_hasValidated) {
      return ValidationResult.success();
    }

    final List<ValidationError> errors = [];

    if (confirmPassword == null || confirmPassword.isEmpty) {
      // Если подтверждение пароля пустое, все требования не выполнены
      errors.add(const ValidationError(type: ValidationErrorType.empty, isFixed: false));
      errors.add(const ValidationError(type: ValidationErrorType.passwordsNotMatch, isFixed: false));
    } else if (password != confirmPassword) {
      // Проверяем совпадение только если подтверждение не пустое
      errors.add(const ValidationError(type: ValidationErrorType.passwordsNotMatch, isFixed: false));
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
