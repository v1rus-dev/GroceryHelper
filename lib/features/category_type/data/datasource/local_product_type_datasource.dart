import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/entities/app_product_type.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';

class LocalProductTypeDatasource {
  AppDatabase appDatabase;

  LocalProductTypeDatasource({required this.appDatabase});

  Future<int> addProductType(ProductCategory category, String name) async {
    return appDatabase
        .into(appDatabase.productTypes)
        .insert(ProductTypesCompanion(name: Value(name), productCategory: Value(category)));
  }

  Stream<List<AppProductTypeUser>> watchProductTypes() {
    return appDatabase.productTypes
        .select()
        .map((item) => AppProductTypeUser(id: item.id, name: item.name, category: item.productCategory))
        .watch();
  }

  Future<List<AppProductTypeUser>> getProductTypes(ProductCategory category) async {
    final productTypes = await (appDatabase.select(
      appDatabase.productTypes,
    )..where((a) => a.productCategory.equals(category.id))).get();
    return productTypes
        .map((item) => AppProductTypeUser(id: item.id, name: item.name, category: item.productCategory))
        .toList();
  }
}
