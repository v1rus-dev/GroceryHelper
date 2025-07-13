import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';

class LocalProductDatasource {
  late final AppDatabase appDatabase;

  LocalProductDatasource({required this.appDatabase});

  Future<void> addProduct(String name, ProductCategory category, int productTypeId) async {
    await appDatabase
        .into(appDatabase.productItemsTable)
        .insert(
          ProductItemsTableCompanion(
            name: Value(name),
            productCategoryId: Value(category),
            productType: Value(productTypeId),
          ),
        );
  }
}
