import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/infrastructure/datasources/local_product_type_datasource.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';

class ProductTypeRepositoryImpl implements ProductTypeRepository {
  final LocalProductTypeDatasource localProductTypeDatasource;

  ProductTypeRepositoryImpl({required this.localProductTypeDatasource});

  @override
  Future<int> addProductType(ProductCategory category, String name) async {
    return localProductTypeDatasource.addProductType(category, name);
  }

  @override
  Stream<List<AppProductType>> watchProductTypes() {
    return localProductTypeDatasource.watchProductTypes().map(
      (list) =>
          list.map((item) => AppProductType(id: item.id, name: item.name, category: item.productCategory)).toList(),
    );
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
