import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/infrastructure/navigation/app_router.dart';
import 'package:groceryhelper/infrastructure/navigation/router_paths.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/app_fub_button.dart';
import 'package:groceryhelper/common_ui/widgets/toolbars/app_main_toolbar.dart';
import 'package:groceryhelper/features/buskets/presentation/bloc/buskets_bloc.dart';

class BusketsScreen extends StatelessWidget {
  const BusketsScreen({super.key});

  _onCreateBusket(BuildContext context) {
    appRouter.push(RouterPaths.createBusket);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BusketsBloc, BusketsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(title: 'Корзины'),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: AppFubButton(
              onTap: () {
                _onCreateBusket(context);
              },
              color: context.theme.busket,
              child: SvgPicture.asset(AppAssets.icAdd),
            ),
            body: Column(children: []),
          );
        },
      ),
    );
  }
}
