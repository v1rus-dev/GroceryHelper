import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/domain/enums/product_category.dart';
import 'package:groceryhelper/core/domain/enums/product_type.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/features/product_form/presentation/bloc/product_form_bloc.dart';
import 'package:groceryhelper/features/product_form/presentation/widgets/category_part.dart';

class ProductFormScreen extends StatelessWidget {
  const ProductFormScreen({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductFormBloc(),
      child: ProductFormScreenView(isEdit: isEdit),
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
    return 'Добавление продукта';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: AppToolbar(title: _getTitle(), withBackButton: true),
      body: BlocBuilder<ProductFormBloc, ProductFormState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(controller: _nameController, labelText: 'Название продукта'),
                const Gap(12),
                CategoryPart(
                  selectedCategory: state.category,
                  selectedType: state.type,
                  onCategorySelected: (category) =>
                      context.read<ProductFormBloc>().add(ProductFormCategorySelected(category: category)),
                  onTypeSelected: (type) => context.read<ProductFormBloc>().add(ProductFormTypeSelected(type: type)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
