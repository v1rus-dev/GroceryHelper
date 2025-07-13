import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/common_ui/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/bottom_sheet_list_item.dart';
import 'package:groceryhelper/common_ui/widgets/utils/drag_handler.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/app_chip.dart';
import 'package:groceryhelper/features/category_type/domain/entities/category_type_result.dart';
import 'package:groceryhelper/features/category_type/presentation/bloc/category_type_bloc.dart';
import 'package:groceryhelper/features/category_type/presentation/bottom_sheet/add_custom_type.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/features/category_type/presentation/widgets/type_item.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';

class CategoryTypeScreen extends StatelessWidget {
  const CategoryTypeScreen({super.key, required this.selectedCategory});

  final ProductCategory selectedCategory;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductTypeRepository>(
      future: locator.getAsync<ProductTypeRepository>(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        return BlocProvider(
          create: (context) => CategoryTypeBloc(selectedCategory, snapshot.data!)..add(CategoryTypeInitialized()),
          child: CategoryTypeScreenView(selectedCategory: selectedCategory),
        );
      },
    );
  }
}

class CategoryTypeScreenView extends StatefulWidget {
  const CategoryTypeScreenView({super.key, required this.selectedCategory});

  final ProductCategory selectedCategory;

  @override
  State<CategoryTypeScreenView> createState() => _CategoryTypeScreenViewState();
}

class _CategoryTypeScreenViewState extends State<CategoryTypeScreenView> {
  void _onTypeTap(BuildContext context, AppProductType type) {
    final selectedCategory = context.read<CategoryTypeBloc>().state.category;
    Navigator.pop(context, CategoryTypeResult(category: selectedCategory, type: type));
  }

  Future<void> _onAddCustomType(ProductCategory category) async {
    final bloc = context.read<CategoryTypeBloc>();

    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddCustomTypeBottomSheet(selectedCategory: category),
      ),
    );

    if (result == null || result is! String) return;

    StateDialogManager.instance.showLoading();

    final completer = Completer();

    bloc.add(CategoryTypeAddCustomType(name: result, category: category, completer: completer));

    completer.future.then((value) {
      StateDialogManager.instance.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      snap: true,
      builder: (context, scrollController) {
        return BlocBuilder<CategoryTypeBloc, CategoryTypeState>(
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DragHandler(),
                  const Gap(8),
                  Center(child: Text('Категория и тип', style: Theme.of(context).textTheme.displayMedium)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: ProductCategory.values
                        .map(
                          (e) => AppChip(
                            label: e.displayName,
                            onTap: () => context.read<CategoryTypeBloc>().add(CategoryTypeSelected(category: e)),
                            color: e.color,
                            isSelected: e == state.category,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('Тип', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Скроллируемая часть
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: [
                        ...state.types.map(
                          (type) => BottomSheetListItem(
                            key: Key(type.displayName),
                            label: type.displayName,
                            onTap: () => _onTypeTap(context, type),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _onAddCustomType(state.category);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text('Добавить тип', style: Theme.of(context).textTheme.bodyMedium),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
