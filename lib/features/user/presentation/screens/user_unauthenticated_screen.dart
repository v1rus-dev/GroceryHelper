import 'package:groceryhelper/core/widgets/google_sign_in_button.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UserUnauthenticatedScreen extends StatelessWidget {
  const UserUnauthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        GoogleSignInButton(
          onPressed: () {
            context.read<UserBloc>().add(AuthByGoogle());
          },
        ),
      ],
    );
  }
}
