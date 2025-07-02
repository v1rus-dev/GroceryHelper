import 'package:groceryhelper/core/navigation/app_router.dart';
import 'package:groceryhelper/core/navigation/router_paths.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/services/new_dialog_service.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_main_toolbar.dart';
import 'package:groceryhelper/core/widgets/buttons/settings_button.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:groceryhelper/features/user/presentation/screens/user_authenticated_screen.dart';
import 'package:groceryhelper/features/user/presentation/screens/user_unauthenticated_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  _onSettingsTap() {
    appRouter.push(RouterPaths.settings);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => previous != current && current is AuthDialogState,
        listener: (context, state) {
          final mappedState = state as AuthDialogState;
          switch (mappedState) {
            case AuthLoading():
              locator<NewDialogService>().showLoading(context, "Вход");
            case AuthFailure():
              locator<NewDialogService>().showError(context, mappedState.error.message);
          }
        },
        buildWhen: (previous, current) => previous != current && current is AuthContentState,
        builder: (context, state) {
          final mappedState = state as AuthContentState;
          return Scaffold(
            appBar: AppMainToolbar(
              title: 'Профиль',
              trailingWidget: SettingsButton(onTap: _onSettingsTap),
            ),
            body: switch (mappedState) {
              AuthInitial() => Column(),
              Authenticated() => UserAuthenticatedScreen(),
              Unauthenticated() => UserUnauthenticatedScreen(),
            },
          );
        },
      ),
    );
  }
}
