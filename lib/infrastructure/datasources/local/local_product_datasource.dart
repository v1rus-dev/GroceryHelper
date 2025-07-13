import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/enums/product_category.dart';
import '../../database/app_database.dart';
import '../interfaces/product_datasource_interface.dart';

class LocalProductDatasource implements ProductDatasourceInterface {
  final AppDatabase _database;

  LocalProductDatasource({required AppDatabase database}) : _database = database;

  @override
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    try {
      final products = await _database.select(_database.productItemsTable).get();
      return right(products.map((product) => _mapToProductItem(product)).toList());
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<Either<AppError, ProductItem?>> getProductById(int id) async {
    try {
      final product = await (_database.select(
        _database.productItemsTable,
      )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

      if (product == null) return right(null);
      return right(_mapToProductItem(product));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<Either<AppError, ProductItem>> createProduct(ProductItem product) async {
    try {
      final companion = ProductItemsTableCompanion.insert(
        name: product.name,
        productCategoryId: product.category,
        productType: product.productTypeId,
        itemId: int.tryParse(product.itemId ?? '0') ?? 0,
      );

      final id = await _database.into(_database.productItemsTable).insert(companion);
      return right(product.copyWith(id: id));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<Either<AppError, void>> updateProduct(ProductItem product) async {
    try {
      final companion = ProductItemsTableCompanion(
        id: Value(product.id),
        name: Value(product.name),
        productCategoryId: Value(product.category),
        productType: Value(product.productTypeId),
        itemId: Value(int.tryParse(product.itemId ?? '0') ?? 0),
      );

      await (_database.update(_database.productItemsTable)..where((tbl) => tbl.id.equals(product.id))).write(companion);

      return right(null);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<Either<AppError, void>> deleteProduct(int id) async {
    try {
      await (_database.delete(_database.productItemsTable)..where((tbl) => tbl.id.equals(id))).go();

      return right(null);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category) async {
    try {
      final products = await (_database.select(
        _database.productItemsTable,
      )..where((tbl) => tbl.productCategoryId.equals(category.index))).get();

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
      itemId: product.itemId?.toString(),
    );
  }
}
