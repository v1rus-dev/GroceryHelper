import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/core/theme/app_theme_extension.dart';
import 'package:groceryhelper/core/widgets/app_fub_button.dart';
import 'package:groceryhelper/core/widgets/app_main_toolbar.dart';
import 'package:groceryhelper/features/shopping_list/presentation/bloc/shopping_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingList extends StatelessWidget {
  const ShoppingList({super.key});

  _onAddItem(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(text: 'Продукты'),
            floatingActionButton: AppFubButton(
              onTap: () {
                _onAddItem(context);
              },
              color: context.theme.primary,
              child: SvgPicture.asset(AppAssets.icAdd),
            ),
            body: Column(children: []),
          );
        },
      ),
    );
  }
}
