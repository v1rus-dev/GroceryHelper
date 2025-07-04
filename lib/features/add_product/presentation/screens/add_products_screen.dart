import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/textFields/app_text_field.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';
import 'package:groceryhelper/features/add_product/presentation/bloc/add_product_bloc.dart';

class AddProductsScreen extends StatelessWidget {
  const AddProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AddProductBloc(), child: const AddProductsScreenView());
  }
}

class AddProductsScreenView extends StatefulWidget {
  const AddProductsScreenView({super.key});

  @override
  State<AddProductsScreenView> createState() => _AddProductsScreenViewState();
}

class _AddProductsScreenViewState extends State<AddProductsScreenView> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: AppToolbar(title: 'Добавление продукта', withBackButton: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(controller: _nameController, labelText: 'Название продукта'),
            const Gap(12),
            Text('Тип', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
