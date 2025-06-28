import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_theme_extension.dart';
import 'package:go_router/go_router.dart';

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pop();
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Уже есть аккаунт? ',
              style: TextStyle(color: context.secondaryTextColor, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: 'Войти!',
              style: TextStyle(color: context.primaryColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
