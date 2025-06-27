import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_text_styles.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/widgets/app_button.dart';
import 'package:groceryhelper/core/widgets/app_text_field.dart';

class UserUnauthenticatedScreen extends StatelessWidget {
  const UserUnauthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Gap(20),
            Text('Чтобы пользоваться всеми возможностями приложения, пожалуйста войдите.', style: AppTextStyles.body),
            const Gap(40),
            AppTextField(hintText: 'Почта'),
            const Gap(8),
            AppTextField(hintText: 'Пароль', isPassword: true),
            const Gap(20),
            AppButton(onPressed: () {}, text: 'Войти'),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}
