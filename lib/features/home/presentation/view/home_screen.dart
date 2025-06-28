import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_main_toolbar.dart';
import 'package:groceryhelper/core/widgets/buttons/switch_theme_button.dart';
import 'package:groceryhelper/features/home/presentation/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(showGroceryHelperTitle: true, trailingWidget: SwitchThemeButton()),
            body: const Column(children: []),
          );
        },
      ),
    );
  }
}
