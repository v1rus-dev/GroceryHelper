import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/app_primary_button.dart';
import 'package:groceryhelper/common_ui/widgets/layouts/app_scaffold.dart';
import 'package:groceryhelper/common_ui/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/common_ui/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/features/product_form/domain/repositories/products_repository.dart';
import 'package:groceryhelper/features/product_form/presentation/bloc/product_form_bloc.dart';
import 'package:groceryhelper/features/product_form/presentation/widgets/category_part.dart';
import 'package:groceryhelper/features/product_form/presentation/widgets/units_part.dart';
import 'package:groceryhelper/infrastructure/navigation/app_router.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator.getAsync<ProductsRepository>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
        }

        return BlocProvider(
          create: (context) => ProductFormBloc(productsRepository: snapshot.data!)..add(const ProductFormInit()),
          child: ProductFormScreenView(isEdit: isEdit),
        );
      },
    );
  }
}

class ProductFormScreenView extends StatefulWidget {
  const ProductFormScreenView({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<ProductFormScreenView> createState() => _ProductFormScreenViewState();
}

class _ProductFormScreenViewState extends State<ProductFormScreenView> {
  final _nameController = TextEditingController();

  String _getTitle() {
    if (widget.isEdit) {
      return 'Редактирование продукта';
    }
    return 'Добавление товара';
  }

  void _onSave() {
    final completer = Completer();
    context.read<ProductFormBloc>().add(ProductFormSave(name: _nameController.text, completer: completer));
    completer.future
        .then((_) {
          appRouter.pop();
        })
        .onError((error, stackTrace) {
          TalkerService.error(error.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFormBloc, ProductFormState>(
      builder: (context, state) {
        return AppScaffold(
          appBar: AppToolbar(title: _getTitle(), withBackButton: true),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      children: [
                        AppTextField(controller: _nameController, labelText: 'Название продукта'),
                        const Gap(12),
                        CategoryPart(
                          selectedCategory: state.category,
                          selectedType: state.type,
                          onCategorySelected: (category, updateType) => context.read<ProductFormBloc>().add(
                            ProductFormCategorySelected(category: category, updateType: updateType),
                          ),
                          onTypeSelected: (type) =>
                              context.read<ProductFormBloc>().add(ProductFormTypeSelected(type: type)),
                        ),
                        const Gap(12),
                        UnitsPart(selectedUnit: state.selectedUnit),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: AppPrimaryButton(onPressed: _onSave, text: "Сохранить"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
