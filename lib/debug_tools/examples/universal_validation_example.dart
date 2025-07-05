import 'package:flutter/material.dart';
import 'package:groceryhelper/domain/validators/universal_validator.dart';
import 'package:groceryhelper/domain/validators/rules/validation_rules.dart';
import 'package:groceryhelper/domain/validators/utils/rule_validation_result.dart';
import 'package:groceryhelper/common_ui/widgets/utils/rule_validation_requirements_list.dart';

/// Пример виджета, демонстрирующий работу универсальной системы валидации
class UniversalValidationExample extends StatefulWidget {
  const UniversalValidationExample({super.key});

  @override
  State<UniversalValidationExample> createState() => _UniversalValidationExampleState();
}

class _UniversalValidationExampleState extends State<UniversalValidationExample> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late UniversalValidator _passwordValidator;
  late UniversalValidator _confirmPasswordValidator;
  late UniversalValidator _emailValidator;

  RuleValidationResult _passwordResult = RuleValidationResult.success([]);
  RuleValidationResult _confirmPasswordResult = RuleValidationResult.success([]);
  RuleValidationResult _emailResult = RuleValidationResult.success([]);

  @override
  void initState() {
    super.initState();

    // Создаем валидаторы с разными наборами правил
    _passwordValidator = UniversalValidator([
      const RequiredRule(),
      const MinLengthRule(8),
      const MaxLengthRule(50),
      const UppercaseRule(),
      const LowercaseRule(),
      const NumbersRule(),
      const SpecialCharsRule(),
    ]);

    _confirmPasswordValidator = UniversalValidator([
      const RequiredRule(),
      PasswordMatchRule(''), // Будет обновляться динамически
    ]);

    _emailValidator = UniversalValidator([const RequiredRule(), const EmailFormatRule()]);

    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onPasswordChanged() {
    final result = _passwordValidator.validate(_passwordController.text);
    setState(() {
      _passwordResult = result;
    });

    // Обновляем валидатор подтверждения пароля
    _confirmPasswordValidator = UniversalValidator([const RequiredRule(), PasswordMatchRule(_passwordController.text)]);
    _onConfirmPasswordChanged();
  }

  void _onConfirmPasswordChanged() {
    final result = _confirmPasswordValidator.validate(_confirmPasswordController.text);
    setState(() {
      _confirmPasswordResult = result;
    });
  }

  void _onEmailChanged() {
    final result = _emailValidator.validate(_emailController.text);
    setState(() {
      _emailResult = result;
    });
  }

  void _startValidation() {
    _passwordValidator.startValidation();
    _confirmPasswordValidator.startValidation();
    _emailValidator.startValidation();
    _onPasswordChanged();
  }

  void _resetValidation() {
    _passwordValidator.reset();
    _confirmPasswordValidator.reset();
    _emailValidator.reset();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _emailController.clear();
    setState(() {
      _passwordResult = RuleValidationResult.success([]);
      _confirmPasswordResult = RuleValidationResult.success([]);
      _emailResult = RuleValidationResult.success([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Универсальная валидация')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Поле email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Введите email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            RuleValidationRequirementsList(validationResult: _emailResult, showRequirements: true),

            const SizedBox(height: 24),

            // Поле пароля
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Пароль',
                hintText: 'Введите пароль',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            RuleValidationRequirementsList(validationResult: _passwordResult, showRequirements: true),

            const SizedBox(height: 24),

            // Поле подтверждения пароля
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Подтвердите пароль',
                hintText: 'Повторите пароль',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 8),
            RuleValidationRequirementsList(validationResult: _confirmPasswordResult, showRequirements: true),

            const SizedBox(height: 24),

            Row(
              children: [
                ElevatedButton(onPressed: _startValidation, child: const Text('Начать валидацию')),
                const SizedBox(width: 16),
                ElevatedButton(onPressed: _resetValidation, child: const Text('Сбросить')),
              ],
            ),

            const SizedBox(height: 24),

            const Text('Преимущества новой системы:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              '• Гибкая настройка правил валидации\n'
              '• Параметризованные правила (длина, формат)\n'
              '• Единый валидатор для всех типов полей\n'
              '• Легкое добавление новых правил\n'
              '• Система приоритизации требований',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
