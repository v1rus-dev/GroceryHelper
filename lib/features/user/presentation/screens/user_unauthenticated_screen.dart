import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/sign_in_with_google.dart';
import 'package:groceryhelper/core/widgets/sign_in_with_apple.dart';
import 'package:groceryhelper/features/user/presentation/widgets/create_account.dart';
import 'package:groceryhelper/features/user/presentation/widgets/email_login_part.dart';
import 'package:groceryhelper/features/user/presentation/widgets/or_part.dart';

class UserUnauthenticatedScreen extends StatefulWidget {
  UserUnauthenticatedScreen({super.key});

  @override
  State<UserUnauthenticatedScreen> createState() => _UserUnauthenticatedScreenState();
}

class _UserUnauthenticatedScreenState extends State<UserUnauthenticatedScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  _onLogIn() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }

    print('onLogIn');
  }

  _onSignInWithGoogle() {
    print('onSignInWithGoogle');
  }

  _onSignInWithApple() {
    print('onSignInWithApple');
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Gap(20),
              EmailLoginPart(
                emailController: _emailController,
                passwordController: _passwordController,
                onLogIn: _onLogIn,
              ),
              const Gap(20),
              OrPart(),
              const Gap(20),
              SignInWithGoogle(onPressed: _onSignInWithGoogle),
              const Gap(8),
              SignInWithApple(onPressed: _onSignInWithApple),
              const Gap(20),
              CreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
