import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

abstract class ProductTypeRepository {
  Future<int> addProductType(ProductCategory category, String name);

  Future<List<ProductType>> getProductTypes(ProductCategory category);

  Stream<List<ProductType>> watchProductTypes();
}
