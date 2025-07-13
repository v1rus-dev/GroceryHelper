import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/enums/product_category.dart';
import '../interfaces/product_datasource_interface.dart';

class NetworkProductDatasource implements ProductDatasourceInterface {
  @override
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    // TODO: Реализовать получение продуктов из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, ProductItem?>> getProductById(int id) async {
    // TODO: Реализовать получение продукта по ID из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, ProductItem>> createProduct(ProductItem product) async {
    // TODO: Реализовать создание продукта в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> updateProduct(ProductItem product) async {
    // TODO: Реализовать обновление продукта в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> deleteProduct(int id) async {
    // TODO: Реализовать удаление продукта из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category) async {
    // TODO: Реализовать получение продуктов по категории из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }
}
