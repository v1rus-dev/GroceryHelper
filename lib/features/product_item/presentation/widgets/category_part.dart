import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/features/category_type/domain/entities/category_type_result.dart';
import 'package:groceryhelper/features/category_type/presentation/screens/category_type_screen.dart';

class CategoryPart extends StatelessWidget {
  const CategoryPart({
    super.key,
    required this.selectedCategory,
    required this.selectedType,
    required this.onCategorySelected,
    required this.onTypeSelected,
  });

  final ProductCategory selectedCategory;
  final ProductType? selectedType;
  final Function(ProductCategory, bool) onCategorySelected;
  final Function(ProductType) onTypeSelected;

  _onTypeTap(BuildContext context, ProductCategory selectedCategory) async {
    final result = await showModalBottomSheet(
      backgroundColor: context.theme.background,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => CategoryTypeScreen(selectedCategory: selectedCategory),
    );
    if (result is CategoryTypeResult) {
      onCategorySelected(result.category, false);
      onTypeSelected(result.type);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Категория и тип", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(4),
        Text('* Обязательно', style: theme.textTheme.labelSmall?.copyWith(color: context.theme.secondaryText)),
        const Gap(8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            ...ProductCategory.values.map(
              (e) => AppChip(
                label: e.displayName,
                onTap: () {
                  onCategorySelected(e, true);
                },
                color: e.color,
                isSelected: e == selectedCategory,
              ),
            ),
          ],
        ),
        const Gap(8),
        DropDownButton(
          label: selectedType?.name,
          hintText: "Выберите название продукта",
          onTap: () => _onTypeTap(context, selectedCategory),
        ),
      ],
    );
  }
}
