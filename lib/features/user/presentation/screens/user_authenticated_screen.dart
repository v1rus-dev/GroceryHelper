import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';
import '../bloc/auth/auth_bloc.dart';

class UserAuthenticatedScreen extends StatelessWidget {
  const UserAuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Text('UserAuthenticatedScreen'),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(Unauthorize());
                },
                child: Column(),
              ),
            ],
          ),
        );
      },
    );
  }
}
