import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/widgets/buttons/app_button.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/features/register/presentation/widgets/login_link.dart';
import 'package:groceryhelper/core/utils/validators/username_validator.dart';
import 'package:groceryhelper/core/utils/validators/email_validator.dart';
import 'package:groceryhelper/core/utils/validators/password_validator.dart';
import 'package:groceryhelper/core/utils/validators/confirm_password_validator.dart';
import 'package:groceryhelper/core/utils/validators/validation_result.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // FocusNode для каждого поля
  final FocusNode _usernameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  // Создаем экземпляры валидаторов
  final UsernameValidator _usernameValidator = UsernameValidator();
  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();
  final ConfirmPasswordValidator _confirmPasswordValidator = ConfirmPasswordValidator();

  // Результаты валидации для каждого поля
  ValidationResult? _usernameValidationResult;
  ValidationResult? _emailValidationResult;
  ValidationResult? _passwordValidationResult;
  ValidationResult? _confirmPasswordValidationResult;

  @override
  void initState() {
    super.initState();
  }

  void _onUsernameSubmitted(String value) {
    _emailFocusNode.requestFocus();
  }

  void _onEmailSubmitted(String value) {
    _passwordFocusNode.requestFocus();
  }

  void _onPasswordSubmitted(String value) {
    _confirmPasswordFocusNode.requestFocus();
  }

  void _onConfirmPasswordSubmitted(String value) {
    // Закрываем клавиатуру на последнем поле
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    // Освобождаем FocusNode
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  void _onRegister() {
    // Запускаем валидацию во всех валидаторах
    _usernameValidator.startValidation();
    _emailValidator.startValidation();
    _passwordValidator.startValidation();
    _confirmPasswordValidator.startValidation();

    // Валидируем все поля
    final usernameResult = _usernameValidator.validate(_usernameController.text);
    final emailResult = _emailValidator.validate(_emailController.text);
    final passwordResult = _passwordValidator.validate(_passwordController.text);
    final confirmPasswordResult = _confirmPasswordValidator.validate(
      _passwordController.text,
      _confirmPasswordController.text,
    );

    setState(() {
      _usernameValidationResult = usernameResult;
      _emailValidationResult = emailResult;
      _passwordValidationResult = passwordResult;
      _confirmPasswordValidationResult = confirmPasswordResult;
    });

    // Если нет ошибок, продолжаем регистрацию
    if (usernameResult.isValid && emailResult.isValid && passwordResult.isValid && confirmPasswordResult.isValid) {
      print('Регистрация успешна!');
      // Здесь будет логика регистрации
    }
  }

  void _onFieldChanged() {
    // Проверяем поля в реальном времени (валидаторы сами решают, показывать ли ошибки)
    setState(() {
      _usernameValidationResult = _usernameValidator.validate(_usernameController.text);
      _emailValidationResult = _emailValidator.validate(_emailController.text);
      _passwordValidationResult = _passwordValidator.validate(_passwordController.text);
      _confirmPasswordValidationResult = _confirmPasswordValidator.validate(
        _passwordController.text,
        _confirmPasswordController.text,
      );
    });
  }

  bool _isFormValid() {
    // Кнопка активна по умолчанию, если валидаторы еще не сработали
    // Отключается только если валидаторы сработали и показали ошибки

    // Проверяем, сработали ли валидаторы (есть ли результаты валидации)
    final hasValidationResults =
        _usernameValidationResult != null ||
        _emailValidationResult != null ||
        _passwordValidationResult != null ||
        _confirmPasswordValidationResult != null;

    // Если валидаторы еще не сработали, кнопка активна
    if (!hasValidationResults) {
      return true;
    }

    // Если валидаторы сработали, проверяем все результаты
    return (_usernameValidationResult?.isValid ?? true) &&
        (_emailValidationResult?.isValid ?? true) &&
        (_passwordValidationResult?.isValid ?? true) &&
        (_confirmPasswordValidationResult?.isValid ?? true);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Регистрация', withBackButton: true, onBackPressed: () => context.pop()),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            AppTextField(
              labelText: 'Имя пользователя',
              leadingIcon: AppAssets.icUser,
              controller: _usernameController,
              focusNode: _usernameFocusNode,
              validationResult: _usernameValidationResult,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onUsernameSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Gap(12),
            AppTextField(
              labelText: 'Почта',
              leadingIcon: AppAssets.icEmail,
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              validationResult: _emailValidationResult,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onEmailSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Gap(12),
            AppTextField(
              labelText: 'Пароль',
              isPassword: true,
              leadingIcon: AppAssets.icPassword,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              validationResult: _passwordValidationResult,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onPasswordSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Gap(12),
            AppTextField(
              labelText: 'Повторите пароль',
              isPassword: true,
              leadingIcon: AppAssets.icPassword,
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              validationResult: _confirmPasswordValidationResult,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onConfirmPasswordSubmitted,
              textInputAction: TextInputAction.done,
            ),
            Gap(12),
            AppButton(text: 'Зарегистрироваться', onPressed: _onRegister, isDisabled: !_isFormValid()),
            const SizedBox(height: 24),
            const LoginLink(),
          ],
        ),
      ),
    );
  }
}
