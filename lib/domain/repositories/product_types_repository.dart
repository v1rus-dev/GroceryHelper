import 'package:dartz/dartz.dart';

import '../../core/errors/errors.dart';
import '../entities/product_type.dart';
import '../enums/product_category.dart';

abstract class ProductTypesRepository {
  Future<Either<AppError, List<ProductType>>> getAllProductTypes();
  Future<Either<AppError, ProductType?>> getProductTypeById(int id);
  Future<Either<AppError, int>> createProductType(String name, ProductCategory category);
  Future<Either<AppError, void>> updateProductType(ProductType productType);
  Future<Either<AppError, void>> deleteProductType(int id);
  Future<Either<AppError, List<ProductType>>> getProductTypesByCategory(ProductCategory category);
  Stream<List<ProductType>> watchProductTypes();
}
