import 'package:design/widgets/buttons/app_fub_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/app/router/router_paths.dart';
import 'package:design/design.dart';
import 'package:design/widgets/text_fields/app_text_field.dart';
import 'package:groceryhelper/features/products_list/presentation/bloc/products_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsList extends StatefulWidget {
  const ProductsList({super.key});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  final TextEditingController _searchController = TextEditingController();

  _onAddItem(BuildContext context) {
    appRouter.push(RouterPaths.productForm, extra: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProductsListBloc, ProductsListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppMainToolbar(title: 'Товары'),
            floatingActionButton: AppFubButton(
              onTap: () {
                _onAddItem(context);
              },
              color: context.theme.primary,
              child: SvgPicture.asset(AppAssets.icAdd),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [AppTextField(controller: _searchController, labelText: 'Поиск')],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
