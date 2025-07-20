import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class ProductCategoryFilter extends StatefulWidget {
  const ProductCategoryFilter({super.key, this.selectedCategory, required this.onCategorySelected});

  final ProductCategory? selectedCategory;
  final Function(ProductCategory?) onCategorySelected;

  @override
  State<ProductCategoryFilter> createState() => _ProductCategoryFilterState();
}

class _ProductCategoryFilterState extends State<ProductCategoryFilter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        itemCount: ProductCategory.values.length + 1,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AppChip(
              label: 'Все',
              isSelected: widget.selectedCategory == null,
              onTap: () {
                widget.onCategorySelected(null);
              },
            );
          }
          final category = ProductCategory.values[index - 1];
          return AppChip(
            label: category.displayName,
            isSelected: category == widget.selectedCategory,
            color: category.color,
            onTap: () {
              widget.onCategorySelected(category);
            },
          );
        },
      ),
    );
  }
}
