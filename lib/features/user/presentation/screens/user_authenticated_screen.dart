import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';

class UserAuthenticatedScreen extends StatelessWidget {
  const UserAuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text('UserAuthenticatedScreen'),
          ElevatedButton(
            onPressed: () {
              context.read<UserBloc>().add(Unauthorize());
            },
            child: Column(),
          ),
        ],
      ),
    );
  }
}
