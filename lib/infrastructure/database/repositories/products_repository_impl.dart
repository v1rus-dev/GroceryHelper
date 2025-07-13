import 'package:dartz/dartz.dart';
import '../../../core/errors/errors.dart';
import '../../../domain/entities/product_item.dart';
import '../../../domain/entities/product_type.dart';
import '../../../domain/enums/product_category.dart';
import '../../../domain/repositories/products_repository.dart';
import '../../datasources/interfaces/product_datasource_interface.dart';
import '../../datasources/interfaces/product_type_datasource_interface.dart';
import '../../services/auth_status_service.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductDatasourceInterface _localProductDatasource;
  final ProductDatasourceInterface _networkProductDatasource;
  final ProductTypeDatasourceInterface _localProductTypeDatasource;
  final ProductTypeDatasourceInterface _networkProductTypeDatasource;
  final AuthStatusService _authStatusService;

  ProductsRepositoryImpl({
    required ProductDatasourceInterface localProductDatasource,
    required ProductDatasourceInterface networkProductDatasource,
    required ProductTypeDatasourceInterface localProductTypeDatasource,
    required ProductTypeDatasourceInterface networkProductTypeDatasource,
    required AuthStatusService authStatusService,
  }) : _localProductDatasource = localProductDatasource,
       _networkProductDatasource = networkProductDatasource,
       _localProductTypeDatasource = localProductTypeDatasource,
       _networkProductTypeDatasource = networkProductTypeDatasource,
       _authStatusService = authStatusService;

  /// Выбирает правильный datasource на основе статуса авторизации
  ProductDatasourceInterface get _productDatasource {
    return _authStatusService.getCurrentUser() != null ? _networkProductDatasource : _localProductDatasource;
  }

  /// Выбирает правильный datasource для типов продуктов на основе статуса авторизации
  ProductTypeDatasourceInterface get _productTypeDatasource {
    return _authStatusService.getCurrentUser() != null ? _networkProductTypeDatasource : _localProductTypeDatasource;
  }

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

      final result = await _productDatasource.createProduct(product);
      return result.fold((error) => left(error), (_) => right(null));
    } catch (e) {
      return left(AppError(message: e.toString(), type: AppErrorType.silent));
    }
  }

  @override
  Future<List<ProductType>> getProductTypes(ProductCategory category) async {
    final result = await _productTypeDatasource.getProductTypesByCategory(category);
    return result.fold(
      (error) => [], // Возвращаем пустой список в случае ошибки
      (types) => types,
    );
  }

  /// Получить все продукты
  @override
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    return await _productDatasource.getAllProducts();
  }

  /// Получить продукт по ID
  @override
  Future<Either<AppError, ProductItem?>> getProductById(int id) async {
    return await _productDatasource.getProductById(id);
  }

  /// Обновить продукт
  @override
  Future<Either<AppError, void>> updateProduct(ProductItem product) async {
    return await _productDatasource.updateProduct(product);
  }

  /// Удалить продукт
  @override
  Future<Either<AppError, void>> deleteProduct(int id) async {
    return await _productDatasource.deleteProduct(id);
  }

  /// Получить продукты по категории
  @override
  Future<Either<AppError, List<ProductItem>>> getProductsByCategory(ProductCategory category) async {
    return await _productDatasource.getProductsByCategory(category);
  }

  /// Получить все типы продуктов
  @override
  Future<Either<AppError, List<ProductType>>> getAllProductTypes() async {
    return await _productTypeDatasource.getAllProductTypes();
  }

  /// Получить тип продукта по ID
  @override
  Future<Either<AppError, ProductType?>> getProductTypeById(int id) async {
    return await _productTypeDatasource.getProductTypeById(id);
  }

  /// Создать тип продукта
  @override
  Future<Either<AppError, ProductType>> createProductType(ProductType productType) async {
    return await _productTypeDatasource.createProductType(productType);
  }

  /// Обновить тип продукта
  @override
  Future<Either<AppError, void>> updateProductType(ProductType productType) async {
    return await _productTypeDatasource.updateProductType(productType);
  }

  /// Удалить тип продукта
  @override
  Future<Either<AppError, void>> deleteProductType(int id) async {
    return await _productTypeDatasource.deleteProductType(id);
  }
}
