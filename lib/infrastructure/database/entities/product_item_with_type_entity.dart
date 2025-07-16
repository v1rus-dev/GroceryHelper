import 'package:groceryhelper/infrastructure/database/entities/product_item_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_type_entity.dart';

class ProductItemWithTypeEntity {
  final ProductItemEntity productItem;
  final ProductTypeEntity productType;

  ProductItemWithTypeEntity({required this.productItem, required this.productType});
}
