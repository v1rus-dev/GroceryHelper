import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  _onAddItem(BuildContext context) {}

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
