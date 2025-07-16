import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/dao/product_types_dao.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_with_type_entity.dart';
import '../../../shared/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../database/app_database.dart';

class LocalProductDatasource {
  final AppDatabase _database;

  final ProductTypesDao _productTypesDao;
  // Оставлен только конструктор, так как других методов в выделении нет и удалять нечего
  LocalProductDatasource({required AppDatabase database})
    : _database = database,
      _productTypesDao = database.productTypesDao;

  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    try {
      final products = await _database.select(_database.productItemsTable).get();
      return right(products.map((product) => _mapToProductItem(product)).toList());
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Future<Either<AppError, ProductItem>> createProduct(ProductItem product) async {
    try {
      final companion = ProductItemsTableCompanion.insert(
        name: product.name,
        productCategoryId: product.category,
        productType: product.productTypeId,
      );

      final id = await _database.into(_database.productItemsTable).insert(companion);
      return right(product.copyWith(id: id));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  Stream<List<ProductItemWithTypeEntity>> observeProducts() {
    return _productTypesDao.watchProductTypes();
  }

  Future<Either<AppError, List<ProductItem>>> searchProducts(String query) async {
    try {
      final products = await (_database.select(
        _database.productItemsTable,
      )..where((tbl) => tbl.name.like('%$query%'))).get();
      return right(products.map((product) => _mapToProductItem(product)).toList());
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  ProductItem _mapToProductItem(ProductItemsTableData product) {
    return ProductItem(
      id: product.id,
      name: product.name,
      category: product.productCategoryId,
      productTypeId: product.productType,
      createdAt: product.createdAt,
    );
  }
}
