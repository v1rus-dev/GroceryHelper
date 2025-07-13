import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_type.dart';
import '../../../domain/enums/product_category.dart';

abstract class ProductTypeDatasourceInterface {
  Future<Either<AppError, List<ProductType>>> getAllProductTypes();
  Future<Either<AppError, ProductType?>> getProductTypeById(int id);
  Future<Either<AppError, ProductType>> createProductType(ProductType productType);
  Future<Either<AppError, void>> updateProductType(ProductType productType);
  Future<Either<AppError, void>> deleteProductType(int id);
  Future<Either<AppError, List<ProductType>>> getProductTypesByCategory(ProductCategory category);
  Stream<List<ProductType>> watchProductTypes();
}
