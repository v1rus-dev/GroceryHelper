import 'package:groceryhelper/core/widgets/app_main_toolbar.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user_bloc.dart';
import 'package:groceryhelper/features/user/presentation/screens/user_authenticated_screen.dart';
import 'package:groceryhelper/features/user/presentation/screens/user_unauthenticated_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(text: 'Профиль'),
            body: switch (state) {
              UserInitial() => Column(),
              UserAuthenticated() => UserAuthenticatedScreen(),
              UserUnauthenticated() => UserUnauthenticatedScreen(),
            },
          );
        },
      ),
    );
  }
}
