import 'package:cookmatch/features/auth/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gap/gap.dart';

class UserUnauthenticatedScreen extends StatelessWidget {
  const UserUnauthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        SignInButton(
          Buttons.Google,
          onPressed: () {
            context.read<UserBloc>().add(AuthByGoogle());
          },
        ),
      ],
    );
  }
}
