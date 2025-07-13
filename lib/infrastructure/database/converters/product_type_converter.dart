import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';

class ProductTypeConverter extends TypeConverter<ProductType, int> {
  const ProductTypeConverter();

  @override
  ProductType fromSql(int fromDb) => ProductTypeHelper.fromId(fromDb);

  @override
  int toSql(ProductType value) => value.id;
}
