import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class ProductCategoryConverter extends TypeConverter<ProductCategory, int> {
  const ProductCategoryConverter();

  @override
  ProductCategory fromSql(int fromDb) => ProductCategoryHelper.fromId(fromDb);

  @override
  int toSql(ProductCategory value) => value.id;
}
