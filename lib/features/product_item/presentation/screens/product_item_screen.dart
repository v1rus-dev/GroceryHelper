import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/shared_ui/widgets/buttons/app_primary_button.dart';
import 'package:groceryhelper/shared_ui/layout/app_scaffold.dart';
import 'package:groceryhelper/shared_ui/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/shared_ui/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/features/product_item/presentation/bloc/product_form_bloc.dart';
import 'package:groceryhelper/features/product_item/presentation/widgets/category_part.dart';
import 'package:groceryhelper/features/product_item/presentation/widgets/units_part.dart';
import 'package:groceryhelper/app/router/app_router.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

class ProductItemScreen extends StatelessWidget {
  const ProductItemScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<ProductItemBloc>()..add(const ProductItemInit()),
      child: ProductItemScreenView(isEdit: isEdit),
    );
  }
}

class ProductItemScreenView extends StatefulWidget {
  const ProductItemScreenView({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  State<ProductItemScreenView> createState() => _ProductItemScreenViewState();
}

class _ProductItemScreenViewState extends State<ProductItemScreenView> {
  final _nameController = TextEditingController();

  String _getTitle() {
    if (widget.isEdit) {
      return 'Редактирование продукта';
    }
    return 'Добавление товара';
  }

  void _onSave() {
    final completer = Completer();
    context.read<ProductItemBloc>().add(ProductItemSave(name: _nameController.text, completer: completer));
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
    return BlocBuilder<ProductItemBloc, ProductItemState>(
      builder: (context, state) {
        return AppScaffold(
          appBar: AppToolbar(title: _getTitle(), withBackButton: true),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    child: Column(
                      children: [
                        AppTextField(controller: _nameController, labelText: 'Название продукта'),
                        const Gap(12),
                        CategoryPart(
                          selectedCategory: state.category,
                          selectedType: state.type,
                          onCategorySelected: (category, updateType) => context.read<ProductItemBloc>().add(
                            ProductItemCategorySelected(category: category, updateType: updateType),
                          ),
                          onTypeSelected: (type) =>
                              context.read<ProductItemBloc>().add(ProductItemTypeSelected(type: type)),
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
