import 'package:dartz/dartz.dart';
import '../../../shared/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/enums/product_category.dart';

class NetworkProductDatasource {
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    // TODO: Реализовать получение продуктов из Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }

  Future<Either<AppError, ProductItem>> createProduct(ProductItem product) async {
    // TODO: Реализовать создание продукта в Firestore
    return left(AppError(message: 'Network datasource not implemented yet', type: AppErrorType.silent));
  }
}
