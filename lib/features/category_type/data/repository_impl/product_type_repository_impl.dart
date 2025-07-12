import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/features/category_type/data/datasource/local_product_type_datasource.dart';
import 'package:groceryhelper/features/category_type/domain/repository/product_type_repository.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';

class ProductTypeRepositoryImpl implements ProductTypeRepository {
  final LocalProductTypeDatasource localProductTypeDatasource;

  ProductTypeRepositoryImpl({required this.localProductTypeDatasource});

  @override
  Future<int> addProductType(ProductCategory category, String name) async {
    TalkerService.log('addProductType: $category, $name');
    return localProductTypeDatasource.addProductType(category, name);
  }

  @override
  Stream<List<AppProductTypeUser>> watchProductTypes() {
    return localProductTypeDatasource.watchProductTypes();
  }

  @override
  Future<List<AppProductTypeUser>> getProductTypes(ProductCategory category) async {
    return localProductTypeDatasource.getProductTypes(category);
  }
}
