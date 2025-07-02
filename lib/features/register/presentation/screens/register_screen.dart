import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/core/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/core/utils/validators/universal_validator.dart';
import 'package:groceryhelper/core/utils/validators/rules/validation_rules.dart';
import 'package:groceryhelper/core/utils/validators/utils/rule_validation_result.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/buttons/app_button.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/core/widgets/textFields/rule_validation_requirements_list.dart';
import 'package:groceryhelper/features/register/presentation/bloc/register_bloc.dart';
import 'package:groceryhelper/features/register/presentation/widgets/login_link.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => RegisterBloc(useMock: true), child: const RegisterScreenView());
  }
}

class RegisterScreenView extends StatefulWidget {
  const RegisterScreenView({super.key});

  @override
  State<RegisterScreenView> createState() => _RegisterScreenViewState();
}

class _RegisterScreenViewState extends State<RegisterScreenView> {
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

  // Менеджер для управления диалогами состояний
  final StateDialogManager _dialogManager = StateDialogManager();

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
    // Очищаем диалоги при уничтожении виджета
    _dialogManager.dispose();

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
      context.read<RegisterBloc>().add(
        RegisterUserEvent(
          username: _usernameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
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
      appBar: AppToolbar(title: 'Регистрация (Тест)', withBackButton: true, onBackPressed: () => context.pop()),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          switch (state) {
            case RegisterInitial():
              null;
            case RegisterLoading():
              _dialogManager.showLoading(context, 'Loading...');
            case RegisterSuccess():
              await _dialogManager.showSuccess(context, 'Registration successful');
              if (context.mounted) {
                context.pop();
              }
            case RegisterError():
              await _dialogManager.showError(context, state.error.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Информация о тестовом режиме
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Тестовый режим',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Регистрация работает в тестовом режиме. Пользователи не создаются в Firebase.\n\nЗанятые email для тестирования:\n• test@example.com\n• admin@test.com\n• user@demo.com',
                        style: TextStyle(color: Colors.orange.shade700, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Gap(20),
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
                    validationResult:
                        _usernameValidationResult ?? RuleValidationResult.success(_usernameValidator.rules),
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
                    validationResult:
                        _passwordValidationResult ?? RuleValidationResult.success(_passwordValidator.rules),
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
                        _confirmPasswordValidationResult ??
                        RuleValidationResult.success(_confirmPasswordValidator.rules),
                    showRequirements: true,
                  ),
                ),
                Gap(12),
                AppButton(text: 'Зарегистрироваться (Тест)', onPressed: _onRegister, isDisabled: !_isFormValid()),
                const SizedBox(height: 24),
                const LoginLink(),
              ],
            ),
          );
        },
      ),
    );
  }
}
