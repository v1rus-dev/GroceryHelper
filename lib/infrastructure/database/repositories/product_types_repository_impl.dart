import 'package:dartz/dartz.dart';
import 'package:groceryhelper/infrastructure/datasources/local/local_product_type_datasource.dart';
import '../../../shared/errors/errors.dart';
import '../../../domain/entities/product_type.dart';
import '../../../domain/enums/product_category.dart';
import '../../../domain/repositories/product_types_repository.dart';
import '../../datasources/network/network_product_type_datasource.dart';

class ProductTypesRepositoryImpl implements ProductTypesRepository {
  final LocalProductTypeDatasource _localDatasource;
  final NetworkProductTypeDatasource _networkDatasource;

  ProductTypesRepositoryImpl({
    required LocalProductTypeDatasource localDatasource,
    required NetworkProductTypeDatasource networkDatasource,
  }) : _localDatasource = localDatasource,
       _networkDatasource = networkDatasource;

  @override
  Future<Either<AppError, List<ProductType>>> getAllProductTypes() async {
    return _localDatasource.getAllProductTypes();
  }

  @override
  Future<Either<AppError, ProductType?>> getProductTypeById(int id) {
    return _localDatasource.getProductTypeById(id);
  }

  @override
  Future<Either<AppError, int>> createProductType(String name, ProductCategory category) {
    return _localDatasource.createProductType(name, category);
  }

  @override
  Future<Either<AppError, void>> updateProductType(ProductType productType) {
    return _localDatasource.updateProductType(productType);
  }

  @override
  Future<Either<AppError, void>> deleteProductType(int id) {
    return _localDatasource.deleteProductType(id);
  }

  @override
  Future<Either<AppError, List<ProductType>>> getProductTypesByCategory(ProductCategory category) {
    return _localDatasource.getProductTypesByCategory(category);
  }

  @override
  Stream<List<ProductType>> watchProductTypes() {
    return _localDatasource.watchProductTypes();
  }
}
