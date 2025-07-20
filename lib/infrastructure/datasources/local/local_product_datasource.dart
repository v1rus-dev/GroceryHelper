import 'package:dartz/dartz.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';
import 'package:groceryhelper/infrastructure/database/dao/product_items_dao.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_with_type_db_entity.dart';
import '../../../shared/errors/errors.dart';

class LocalProductDatasource {
  final ProductItemsDao _productItemsDao;

  LocalProductDatasource({required ProductItemsDao productItemsDao}) : _productItemsDao = productItemsDao;

  Future<Either<AppError, List<ProductItemWithTypeDbEntity>>> getAllProducts() async {
    try {
      final products = await _productItemsDao.getProductItems();
      return right(products);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, ProductItemWithTypeDbEntity>> createProduct(ProductItem product) async {
    try {
      final productWithType = await _productItemsDao.createProduct(product);
      return right(productWithType);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Stream<List<ProductItemWithTypeDbEntity>> observeProducts() {
    return _productItemsDao.watchProductItems();
  }

  Future<Either<AppError, List<ProductItemWithTypeDbEntity>>> searchProducts(String query) async {
    try {
      final products = await _productItemsDao.searchProducts(query);
      return right(products);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }
}
