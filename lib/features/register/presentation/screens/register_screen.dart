import 'package:flutter/material.dart';
import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/utils/validators/universal_validator.dart';
import 'package:groceryhelper/core/utils/validators/rules/validation_rules.dart';
import 'package:groceryhelper/core/utils/validators/utils/rule_validation_result.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/buttons/app_button.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/core/widgets/textFields/rule_validation_requirements_list.dart';
import 'package:groceryhelper/features/register/presentation/widgets/login_link.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';
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

  // Универсальные валидаторы
  final UniversalValidator _usernameValidator = UniversalValidator([
    const RequiredRule(),
    const MinLengthRule(3),
    const MaxLengthRule(32),
  ]);
  final UniversalValidator _emailValidator = UniversalValidator([const RequiredRule(), const EmailFormatRule()]);
  final UniversalValidator _passwordValidator = UniversalValidator([
    const RequiredRule(),
    const MinLengthRule(8),
    const MaxLengthRule(50),
    const UppercaseRule(),
    const LowercaseRule(),
    const NumbersRule(),
  ]);
  late UniversalValidator _confirmPasswordValidator;

  // Результаты валидации для каждого поля
  RuleValidationResult? _usernameValidationResult;
  RuleValidationResult? _emailValidationResult;
  RuleValidationResult? _passwordValidationResult;
  RuleValidationResult? _confirmPasswordValidationResult;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_onFieldChanged);
    _emailController.addListener(_onFieldChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onFieldChanged);
    _confirmPasswordValidator = UniversalValidator([const RequiredRule(), PasswordMatchRule(_passwordController.text)]);
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
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _onRegister() {
    _usernameValidator.startValidation();
    _emailValidator.startValidation();
    _passwordValidator.startValidation();
    _confirmPasswordValidator.startValidation();
    final usernameResult = _usernameValidator.validate(_usernameController.text);
    final emailResult = _emailValidator.validate(_emailController.text);
    final passwordResult = _passwordValidator.validate(_passwordController.text);
    final confirmPasswordResult = _confirmPasswordValidator.validate(_confirmPasswordController.text);
    setState(() {
      _usernameValidationResult = usernameResult;
      _emailValidationResult = emailResult;
      _passwordValidationResult = passwordResult;
      _confirmPasswordValidationResult = confirmPasswordResult;
    });
    if (usernameResult.isValid && emailResult.isValid && passwordResult.isValid && confirmPasswordResult.isValid) {
      print('Регистрация успешна!');
      // Здесь будет логика регистрации
    }
  }

  void _onPasswordChanged() {
    // Обновляем валидатор подтверждения пароля с новым значением
    _confirmPasswordValidator = UniversalValidator([const RequiredRule(), PasswordMatchRule(_passwordController.text)]);
    _onFieldChanged();
  }

  void _onFieldChanged() {
    setState(() {
      _usernameValidationResult = _usernameValidator.validate(_usernameController.text);
      _emailValidationResult = _emailValidator.validate(_emailController.text);
      _passwordValidationResult = _passwordValidator.validate(_passwordController.text);
      _confirmPasswordValidationResult = _confirmPasswordValidator.validate(_confirmPasswordController.text);
    });
  }

  bool _isFormValid() {
    final hasValidationResults =
        _usernameValidationResult != null ||
        _emailValidationResult != null ||
        _passwordValidationResult != null ||
        _confirmPasswordValidationResult != null;
    if (!hasValidationResults) {
      return true;
    }
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
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onUsernameSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RuleValidationRequirementsList(
                validationResult: _usernameValidationResult ?? RuleValidationResult.success(_usernameValidator.rules),
                showRequirements: true,
              ),
            ),
            Gap(12),
            AppTextField(
              labelText: 'Почта',
              leadingIcon: AppAssets.icEmail,
              controller: _emailController,
              focusNode: _emailFocusNode,
              keyboardType: TextInputType.emailAddress,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onEmailSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RuleValidationRequirementsList(
                validationResult: _emailValidationResult ?? RuleValidationResult.success(_emailValidator.rules),
                showRequirements: true,
              ),
            ),
            Gap(12),
            AppTextField(
              labelText: 'Пароль',
              isPassword: true,
              leadingIcon: AppAssets.icPassword,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              onChanged: (_) => _onPasswordChanged(),
              onSubmitted: _onPasswordSubmitted,
              textInputAction: TextInputAction.next,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RuleValidationRequirementsList(
                validationResult: _passwordValidationResult ?? RuleValidationResult.success(_passwordValidator.rules),
                showRequirements: true,
              ),
            ),
            Gap(12),
            AppTextField(
              labelText: 'Повторите пароль',
              isPassword: true,
              leadingIcon: AppAssets.icPassword,
              controller: _confirmPasswordController,
              focusNode: _confirmPasswordFocusNode,
              onChanged: (_) => _onFieldChanged(),
              onSubmitted: _onConfirmPasswordSubmitted,
              textInputAction: TextInputAction.done,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RuleValidationRequirementsList(
                validationResult:
                    _confirmPasswordValidationResult ?? RuleValidationResult.success(_confirmPasswordValidator.rules),
                showRequirements: true,
              ),
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
