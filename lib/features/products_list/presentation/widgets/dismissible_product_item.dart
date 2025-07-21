import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import 'package:groceryhelper/features/products_list/presentation/widgets/product_item.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

class DismissibleProductItem extends StatelessWidget {
  final ProductItemWithType product;
  final Function(ProductItemWithType) onTap;
  final Function(ProductItemWithType) onDelete;

  const DismissibleProductItem({super.key, required this.product, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Slidable(
        key: Key(product.productItem.id.toString()),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => _showDeleteConfirmationDialog(context),
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Удалить',
              borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
            ),
          ],
        ),
        child: ProductItem(product: product, onTap: onTap),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    final result = await StateDialogManager.instance.showConfirmDialog(
      'Вы уверены, что хотите удалить "${product.productItem.name}"? Это действие нельзя отменить.',
      optionsBuilder: () => {'Cancel': false, 'Delete': true},
      title: 'Удалить товар?',
    );

    TalkerService.log('result: $result');

    if (result is bool && result == true) {
      onDelete(product);
    }
  }
}
