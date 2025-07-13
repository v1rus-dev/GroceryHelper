import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';

class CategoryTypeItem extends StatelessWidget {
  const CategoryTypeItem({super.key, required this.type, required this.onTap});

  final AppProductType type;
  final Function(AppProductType) onTap;

  String get displayName => switch (type) {
    AppProductTypeDefault() => type.displayName,
    AppProductTypeUser() => type.displayName,
  };

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
                  child: Text(displayName, style: Theme.of(context).textTheme.bodyMedium),
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
