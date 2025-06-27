import 'package:flutter/material.dart';

class UserUnauthenticatedScreen extends StatelessWidget {
  const UserUnauthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [Text('UserUnauthenticatedScreen')]));
  }
}
