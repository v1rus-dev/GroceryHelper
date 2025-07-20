import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.onTap});

  final ProductItemWithType product;
  final Function(ProductItemWithType) onTap;

  Widget _buildProductCategory(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: product.productItem.category.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        product.productItem.category.displayName,
        style: theme.textTheme.labelSmall?.copyWith(color: product.productItem.category.color),
      ),
    );
  }

  String _getProductTypeName(ProductItemWithType product) {
    if (product.productType.isCustom == true) {
      return product.productType.name;
    }
    return product.productType.productType.displayName;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: context.theme.background,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.theme.border, width: 1),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => onTap(product),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productItem.name,
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _getProductTypeName(product),
                        style: theme.textTheme.bodySmall?.copyWith(color: context.theme.secondaryText),
                      ),
                    ],
                  ),
                ),
                _buildProductCategory(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
