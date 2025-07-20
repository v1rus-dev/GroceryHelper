import 'package:dartz/dartz.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import '../../shared/errors/errors.dart';
import '../entities/product_type.dart';
import '../enums/product_category.dart';

abstract class ProductsRepository {
  Future<Either<AppError, void>> addProduct(String name, ProductCategory category, ProductType productType);

  Future<Either<AppError, List<ProductItemWithType>>> getAllProducts();
  Future<Either<AppError, List<ProductItemWithType>>> searchProducts(String query);
  Stream<List<ProductItemWithType>> observeProducts();
}
