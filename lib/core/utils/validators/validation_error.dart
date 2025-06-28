enum ValidationErrorType {
  empty,
  tooShort,
  tooLong,
  invalidFormat,
  noUppercase,
  noLowercase,
  noNumbers,
  noSpecialChars,
  passwordsNotMatch,
  invalidEmail,
}

class ValidationError {
  final ValidationErrorType type;
  final bool isFixed;

  const ValidationError({required this.type, required this.isFixed});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValidationError && other.type == type && other.isFixed == isFixed;
  }

  @override
  int get hashCode => type.hashCode ^ isFixed.hashCode;
}
