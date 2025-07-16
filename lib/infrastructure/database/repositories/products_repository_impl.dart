import 'package:dartz/dartz.dart';
import 'package:groceryhelper/domain/entities/product_item_with_type.dart';
import '../../../shared/errors/errors.dart';
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

  @override
  Future<Either<AppError, List<ProductItem>>> getAllProducts() async {
    return await _localProductDatasource.getAllProducts();
  }

  @override
  Stream<List<ProductItemWithType>> observeProducts() {
    return _localProductDatasource.observeProducts().map(
      (products) => products
          .map(
            (product) => ProductItemWithType(
              productItem: ProductItem(
                id: product.productItem.id,
                name: product.productItem.name,
                category: ProductCategoryHelper.fromId(product.productItem.productCategoryId),
                productTypeId: product.productItem.productTypeId,
                createdAt: product.productItem.createdAt,
              ),
              productType: ProductType(
                id: product.productType.id,
                name: product.productType.name,
                category: ProductCategoryHelper.fromId(product.productType.productCategoryId),
                createdAt: product.productType.createdAt,
                isCustom: product.productType.isCustom,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Future<Either<AppError, List<ProductItem>>> searchProducts(String query) async {
    return await _localProductDatasource.searchProducts(query);
  }
}
