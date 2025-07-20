import 'package:groceryhelper/infrastructure/database/entities/product_item_db_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_type_db_entity.dart';

class ProductItemWithTypeDbEntity {
  final ProductItemDbEntity productItem;
  final ProductTypeDbEntity productType;

  ProductItemWithTypeDbEntity({required this.productItem, required this.productType});
}
