part of '../../register.dart';

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
              style: AppTextStyles.body.copyWith(color: context.theme.secondaryText),
            ),
            TextSpan(
              text: 'Войти!',
              style: AppTextStyles.body.copyWith(color: context.theme.primary),
            ),
          ],
        ),
      ),
    );
  }
}
