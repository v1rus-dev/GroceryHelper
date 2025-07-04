import 'package:groceryhelper/core/domain/enums/product_category.dart';
import 'package:groceryhelper/core/domain/enums/product_type.dart';

class CategoryTypeResult {
  final ProductCategory category;
  final ProductType type;

  CategoryTypeResult({required this.category, required this.type});
}
