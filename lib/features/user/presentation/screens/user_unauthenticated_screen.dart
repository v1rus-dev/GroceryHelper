import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/sign_in_with_google.dart';
import 'package:groceryhelper/features/user/presentation/widgets/create_account.dart';
import 'package:groceryhelper/features/user/presentation/widgets/email_login_part.dart';
import 'package:groceryhelper/features/user/presentation/widgets/or_part.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

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
    context.read<AuthBloc>().add(AuthByEmail(email: _emailController.text, password: _passwordController.text));
  }

  _onSignInWithGoogle() {
    context.read<AuthBloc>().add(AuthByGoogle());
  }

  // _onSignInWithApple() {
  //   context.read<AuthBloc>().add(AuthByApple());
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            // const Gap(8),
            // SignInWithApple(onPressed: _onSignInWithApple),
            const Gap(20),
            CreateAccount(),
            const Gap(20),
          ],
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
