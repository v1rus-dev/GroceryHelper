import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/core/domain/enums/product_category.dart';
import 'package:groceryhelper/core/domain/enums/product_type.dart';
import 'package:groceryhelper/core/widgets/app_chip.dart';
import 'package:groceryhelper/features/category_type/domain/entities/category_type_result.dart';
import 'package:groceryhelper/features/category_type/presentation/bloc/category_type_bloc.dart';

class CategoryTypeScreen extends StatelessWidget {
  const CategoryTypeScreen({super.key, required this.selectedCategory});

  final ProductCategory selectedCategory;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryTypeBloc(selectedCategory),
      child: CategoryTypeScreenView(selectedCategory: selectedCategory),
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
  void _onTypeTap(BuildContext context, ProductType type) {
    final selectedCategory = context.read<CategoryTypeBloc>().state.category;
    Navigator.pop(context, CategoryTypeResult(category: selectedCategory, type: type));
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
                  Container(color: Color(0xFFD9D9D9), height: 4, width: 44),
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
                          (type) => Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => _onTypeTap(context, type),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Text(type.displayName, style: Theme.of(context).textTheme.bodyMedium),
                              ),
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
