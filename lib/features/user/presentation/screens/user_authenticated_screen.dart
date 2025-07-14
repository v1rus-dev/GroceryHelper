import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/shared_ui/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/shared_ui/theme/app_text_styles.dart';
import 'package:groceryhelper/shared_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/shared_ui/widgets/buttons/app_secondary_button.dart';
import 'package:groceryhelper/features/user/presentation/bloc/auth/auth_bloc.dart';
import 'package:groceryhelper/features/user/presentation/bloc/user/user_bloc.dart';

class UserAuthenticatedScreen extends StatelessWidget {
  final User user;

  const UserAuthenticatedScreen({super.key, required this.user});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(16),
                if (user.displayName != null) Text(user.displayName!, style: AppTextStyles.headline2),
                if (user.email != null)
                  Column(
                    children: [
                      const Gap(8),
                      Text(user.email!, style: AppTextStyles.body.copyWith(color: context.theme.secondaryText)),
                    ],
                  ),
                const Gap(40),
                AppSecondaryButton(
                  onPressed: () {
                    _onUnauthorize();
                  },
                  text: "Выйти",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
