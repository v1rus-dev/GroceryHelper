import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

abstract class ProductsRepository {
  Future<Either<AppError, void>> addProduct(String name, ProductCategory category, AppProductType productType);
  Future<List<AppProductType>> getProductTypes(ProductCategory category);
}
