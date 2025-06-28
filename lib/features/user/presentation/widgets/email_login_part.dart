import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:groceryhelper/core/widgets/buttons/app_button.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';

class EmailLoginPart extends StatelessWidget {
  const EmailLoginPart({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onLogIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLogIn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Чтобы пользоваться всеми возможностями приложения, пожалуйста войдите.', style: AppTextStyles.body),
        const Gap(40),
        AppTextField(labelText: 'Почта', leadingIcon: AppAssets.icEmail, controller: emailController),
        const Gap(8),
        AppTextField(
          labelText: 'Пароль',
          isPassword: true,
          leadingIcon: AppAssets.icPassword,
          controller: passwordController,
        ),
        const Gap(20),
        AppButton(onPressed: onLogIn, text: 'Войти'),
      ],
    );
  }
}
