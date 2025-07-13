import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/entities/product_type.dart';
import '../../../domain/enums/product_category.dart';
import '../../../domain/repositories/products_repository.dart';
import '../../datasources/local/local_product_datasource.dart';
import '../../datasources/network/network_product_datasource.dart';
import '../../services/auth_status_service.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final LocalProductDatasource _localProductDatasource;
  final NetworkProductDatasource _networkProductDatasource;
  final AuthStatusService _authStatusService;

  ProductsRepositoryImpl({
    required LocalProductDatasource localProductDatasource,
    required NetworkProductDatasource networkProductDatasource,
    required AuthStatusService authStatusService,
  }) : _localProductDatasource = localProductDatasource,
       _networkProductDatasource = networkProductDatasource,
       _authStatusService = authStatusService;

  @override
  Future<Either<AppError, void>> addProduct(String name, ProductCategory category, ProductType productType) async {
    try {
      final product = ProductItem(
        id: 0, // Будет установлен datasource
        name: name,
        category: category,
        productTypeId: productType.id,
        createdAt: DateTime.now(),
      );

      final result = await _localProductDatasource.createProduct(product);
      return result.fold((error) => left(error), (_) => right(null));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  /// Получить все продукты
  @override
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    return await _localProductDatasource.getAllProducts();
  }

  /// Получить продукт по ID
  @override
  Future<Either<AppError, ProductItem?>> getProductById(int id) async {
    return await _localProductDatasource.getProductById(id);
  }

  /// Обновить продукт
  @override
  Future<Either<AppError, void>> updateProduct(ProductItem product) async {
    return await _localProductDatasource.updateProduct(product);
  }

  /// Удалить продукт
  @override
  Future<Either<AppError, void>> deleteProduct(int id) async {
    return await _localProductDatasource.deleteProduct(id);
  }

  /// Получить продукты по категории
  @override
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category) async {
    return await _localProductDatasource.getProductsByCategory(category);
  }
}
