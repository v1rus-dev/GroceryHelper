import 'package:cookmatch/core/services/locator.dart';
import 'package:cookmatch/features/auth/user/domain/usecase/auth_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class UserAuthenticatedScreen extends StatelessWidget {
  const UserAuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = locator.get<AuthUsecase>().currentUser;
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (user != null && user.displayName != null)
            Text(
              'Привет, ${user.displayName!}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(Unauthorize());
            },
            child: const Text('Unauthorize'),
          ),
        ],
      ),
    );
  }
}
