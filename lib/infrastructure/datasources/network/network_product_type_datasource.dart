import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_type.dart';
import '../../../domain/enums/product_category.dart';
import '../interfaces/product_type_datasource_interface.dart';

class NetworkProductTypeDatasource implements ProductTypeDatasourceInterface {
  @override
  Future<Either<AppError, List<ProductType>>> getAllProductTypes() async {
    // TODO: Реализовать получение типов продуктов из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Stream<List<ProductType>> watchProductTypes() {
    // TODO: Реализовать stream для отслеживания изменений
    return Stream.value([]);
  }

  @override
  Future<Either<AppError, ProductType?>> getProductTypeById(int id) async {
    // TODO: Реализовать получение типа продукта по ID из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, ProductType>> createProductType(ProductType productType) async {
    // TODO: Реализовать создание типа продукта в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> updateProductType(ProductType productType) async {
    // TODO: Реализовать обновление типа продукта в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, void>> deleteProductType(int id) async {
    // TODO: Реализовать удаление типа продукта из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  @override
  Future<Either<AppError, List<ProductType>>> getProductTypesByCategory(ProductCategory category) async {
    // TODO: Реализовать получение типов продуктов по категории из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }
}
