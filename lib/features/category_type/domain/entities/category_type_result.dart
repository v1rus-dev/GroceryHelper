import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class CategoryTypeResult {
  final ProductCategory category;
  final AppProductType type;

  CategoryTypeResult({required this.category, required this.type});
}
