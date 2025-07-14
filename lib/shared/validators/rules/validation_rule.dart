part of '../validators.dart';

/// Базовый интерфейс для правил валидации
abstract class ValidationRule {
  const ValidationRule();

  /// Валидирует значение согласно правилу
  /// Возвращает true, если правило выполнено, false - если нарушено
  bool validate(String? value);
}
