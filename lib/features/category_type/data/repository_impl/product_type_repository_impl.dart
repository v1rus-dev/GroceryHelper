import 'package:groceryhelper/domain/entities/product_type.dart';
import 'package:groceryhelper/infrastructure/datasources/interfaces/product_type_datasource_interface.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/services/auth_status_service.dart';

class ProductTypeRepositoryImpl implements ProductTypeRepository {
  final ProductTypeDatasourceInterface _localProductTypeDatasource;
  final ProductTypeDatasourceInterface _networkProductTypeDatasource;
  final AuthStatusService _authStatusService;

  ProductTypeRepositoryImpl({
    required ProductTypeDatasourceInterface localProductTypeDatasource,
    required ProductTypeDatasourceInterface networkProductTypeDatasource,
    required AuthStatusService authStatusService,
  }) : _localProductTypeDatasource = localProductTypeDatasource,
       _networkProductTypeDatasource = networkProductTypeDatasource,
       _authStatusService = authStatusService;

  /// Выбирает правильный datasource на основе статуса авторизации
  ProductTypeDatasourceInterface get _productTypeDatasource {
    return _authStatusService.getCurrentUser() != null ? _networkProductTypeDatasource : _localProductTypeDatasource;
  }

  @override
  Future<int> addProductType(ProductCategory category, String name) async {
    final productType = ProductType(
      id: 0, // Будет установлен datasource
      name: name,
      category: category,
      createdAt: DateTime.now(),
      isCustom: true,
    );

    final result = await _productTypeDatasource.createProductType(productType);
    return result.fold((error) => throw Exception(error.message), (createdType) => createdType.id);
  }

  @override
  Future<List<ProductType>> getProductTypes(ProductCategory category) async {
    final result = await _productTypeDatasource.getProductTypesByCategory(category);
    return result.fold(
      (error) => [], // Возвращаем пустой список в случае ошибки
      (types) => types,
    );
  }

  @override
  Stream<List<ProductType>> watchProductTypes() {
    return _localProductTypeDatasource.watchProductTypes();
  }
}
