import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class CategoryTypeResult {
  final ProductCategory category;
  final ProductType type;

  CategoryTypeResult({required this.category, required this.type});
}
