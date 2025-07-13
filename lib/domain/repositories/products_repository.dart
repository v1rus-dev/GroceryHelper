import 'package:dartz/dartz.dart';
import '../../core/errors/errors.dart';
import '../entities/product_item.dart';
import '../entities/product_type.dart';
import '../enums/product_category.dart';

abstract class ProductsRepository {
  Future<Either<AppError, void>> addProduct(String name, ProductCategory category, ProductType productType);
  Future<List<ProductType>> getProductTypes(ProductCategory category);

  // Дополнительные методы для работы с продуктами
  Future<Either<AppError, List<ProductItem>>> getAllProducts();
  Future<Either<AppError, ProductItem?>> getProductById(int id);
  Future<Either<AppError, void>> updateProduct(ProductItem product);
  Future<Either<AppError, void>> deleteProduct(int id);
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category);

  // Дополнительные методы для работы с типами продуктов
  Future<Either<AppError, List<ProductType>>> getAllProductTypes();
  Future<Either<AppError, ProductType?>> getProductTypeById(int id);
  Future<Either<AppError, ProductType>> createProductType(ProductType productType);
  Future<Either<AppError, void>> updateProductType(ProductType productType);
  Future<Either<AppError, void>> deleteProductType(int id);
}
