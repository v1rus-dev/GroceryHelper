import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

abstract class ProductTypeRepository {
  Future<int> addProductType(ProductCategory category, String name);

  Future<List<AppProductTypeUser>> getProductTypes(ProductCategory category);

  Stream<List<AppProductTypeUser>> watchProductTypes();
}
