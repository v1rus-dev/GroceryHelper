import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/datasources/local_product_datasource.dart';
import 'package:groceryhelper/infrastructure/datasources/local_product_type_datasource.dart';
import 'package:groceryhelper/domain/repositories/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final LocalProductDatasource localProductDatasource;
  final LocalProductTypeDatasource localProductTypeDatasource;

  ProductsRepositoryImpl({required this.localProductDatasource, required this.localProductTypeDatasource});

  @override
  Future<Either<AppError, void>> addProduct(String name, ProductCategory category, AppProductType productType) async {
    try {
      await localProductDatasource.addProduct(name, category, productType.id);
      return right(null);
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<List<AppProductType>> getProductTypes(ProductCategory category) async {
    return localProductTypeDatasource
        .getProductTypes(category)
        .then(
          (list) =>
              list.map((item) => AppProductType(id: item.id, name: item.name, category: item.productCategory)).toList(),
        );
  }
}
