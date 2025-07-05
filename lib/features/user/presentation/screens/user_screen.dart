import 'package:groceryhelper/infrastructure/navigation/app_router.dart';
import 'package:groceryhelper/infrastructure/navigation/router_paths.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/common_ui/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/debug_tools/presentation/widgets/safe_content_builder.dart';
import 'package:groceryhelper/common_ui/widgets/toolbars/app_main_toolbar.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/settings_button.dart';
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
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev != curr && curr is AuthDialogState,
        listener: (context, state) async {
          final mappedState = state as AuthDialogState;
          switch (mappedState) {
            case AuthLoading():
              StateDialogManager.instance.showLoading();
            case AuthFailure():
              await StateDialogManager.instance.showError(mappedState.error.message);
            case AuthSuccess():
              StateDialogManager.instance.dispose();
          }
          locator<AuthBloc>().add(ResetToContentState());
        },
        child: SafeContentBuilder<AuthBloc, AuthState, AuthContentState>(
          buildWhen: (prev, curr) => prev != curr && curr is AuthContentState,
          builder: (context, state) {
            return Scaffold(
              appBar: AppMainToolbar(
                title: 'Профиль',
                trailingWidget: SettingsButton(onTap: _onSettingsTap),
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: switch (state) {
                  AuthInitial() => Column(mainAxisSize: MainAxisSize.min),
                  Authenticated() => UserAuthenticatedScreen(user: state.user),
                  Unauthenticated() => UserUnauthenticatedScreen(),
                },
              ),
              resizeToAvoidBottomInset: true,
            );
          },
        ),
      ),
    );
  }
}
