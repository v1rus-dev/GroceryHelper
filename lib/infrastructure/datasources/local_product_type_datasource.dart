import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';

class LocalProductTypeDatasource {
  final AppDatabase appDatabase;

  LocalProductTypeDatasource({required this.appDatabase});

  Future<int> addProductType(ProductCategory category, String name) async {
    return appDatabase
        .into(appDatabase.productTypesTable)
        .insert(ProductTypesTableCompanion(name: Value(name), productCategory: Value(category)));
  }

  Stream<List<ProductTypesTableData>> watchProductTypes() {
    return appDatabase.productTypesTable.select().watch();
  }

  Future<List<ProductTypesTableData>> getProductTypes(ProductCategory category) async {
    final productTypes = await (appDatabase.select(
      appDatabase.productTypesTable,
    )..where((a) => a.productCategory.equals(category.id))).get();
    return productTypes.toList();
  }
}
