import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/enums/product_category.dart';

abstract class ProductDatasourceInterface {
  Future<Either<AppError, List<ProductItem>>> getAllProducts();
  Future<Either<AppError, ProductItem?>> getProductById(int id);
  Future<Either<AppError, ProductItem>> createProduct(ProductItem product);
  Future<Either<AppError, void>> updateProduct(ProductItem product);
  Future<Either<AppError, void>> deleteProduct(int id);
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category);
}
