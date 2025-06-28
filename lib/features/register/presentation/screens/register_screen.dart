import 'package:flutter/material.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/app_toolbar.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем информацию о том, с какого экрана мы пришли
    final extra = GoRouter.of(context).state.extra as Map<String, dynamic>?;
    final fromScreen = extra?['fromScreen'] as String?;

    return AppScaffold(
      appBar: AppToolbar(
        title: 'Регистрация',
        withBackButton: true,
        onBackPressed: () {
          // При возврате просто используем стандартный pop
          context.pop();
        },
      ),
      body: SafeArea(child: Column(children: [Text('Регистрация')])),
    );
  }
}
