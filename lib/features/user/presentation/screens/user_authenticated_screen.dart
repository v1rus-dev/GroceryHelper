import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/core/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/core/services/locator.dart';
import 'package:groceryhelper/core/widgets/buttons/app_button.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';

class UserAuthenticatedScreen extends StatelessWidget {
  const UserAuthenticatedScreen({super.key});

  _onUnauthorize() async {
    final result = await StateDialogManager.instance.showConfirmDialog(
      "Вы уверены, что хотите выйти?",
      optionsBuilder: () => {"Выйти": true, "Отмена": null},
    );

    if (result == true) {
      locator<AuthBloc>().add(Unauthorize());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              AppButton(
                onPressed: () {
                  _onUnauthorize();
                },
                text: "Выйти",
              ),
            ],
          ),
        );
      },
    );
  }
}
