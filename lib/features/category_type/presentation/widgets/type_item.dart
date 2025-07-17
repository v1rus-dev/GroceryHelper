import 'package:flutter/material.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/domain/entities/product_type.dart';

class CategoryTypeItem extends StatelessWidget {
  const CategoryTypeItem({super.key, required this.type, required this.onTap});

  final ProductType type;
  final Function(ProductType) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onTap(type),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(type.name, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
        Divider(color: context.theme.divider, height: 1, thickness: 1),
      ],
    );
  }
}
