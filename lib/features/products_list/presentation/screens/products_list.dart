import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';
import 'package:groceryhelper/infrastructure/navigation/app_router.dart';
import 'package:groceryhelper/infrastructure/navigation/router_paths.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/app_fub_button.dart';
import 'package:groceryhelper/common_ui/widgets/toolbars/app_main_toolbar.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  _onAddItem(BuildContext context) {
    appRouter.push(RouterPaths.productForm, extra: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProductsListBloc, ProductsListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(title: 'Продукты'),
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
