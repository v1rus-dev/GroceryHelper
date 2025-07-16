import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_with_type_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_type_entity.dart';
import 'package:groceryhelper/infrastructure/database/tables/product_items_table.dart';

part 'product_types_dao.g.dart';

@DriftAccessor(tables: [ProductItemsTable])
class ProductTypesDao extends DatabaseAccessor<AppDatabase> with _$ProductTypesDaoMixin {
  ProductTypesDao(super.db);

  Future<List<ProductItemWithTypeEntity>> getProductTypes() async {
    final query = select(
      productItemsTable,
    ).join([innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id))]);
    final result = await query.get();
    return result.map((row) {
      final itemRow = row.readTable(productItemsTable);
      final typeRow = row.readTable(productTypesTable);

      final item = ProductItemEntity(
        id: itemRow.id,
        name: itemRow.name,
        productCategoryId: itemRow.productCategoryId.id,
        productTypeId: itemRow.productType,
        createdAt: itemRow.createdAt,
      );
      final type = ProductTypeEntity(
        id: typeRow.id,
        name: typeRow.name,
        productCategoryId: typeRow.productCategory.id,
        createdAt: typeRow.createdAt,
        isCustom: typeRow.isCustom,
        productType: typeRow.productType?.id ?? ProductType.other.id,
      );

      return ProductItemWithTypeEntity(productItem: item, productType: type);
    }).toList();
  }

  Stream<List<ProductItemWithTypeEntity>> watchProductTypes() {
    return select(productItemsTable)
        .join([innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id))])
        .watch()
        .map(
          (event) => event.map((row) {
            final itemRow = row.readTable(productItemsTable);
            final typeRow = row.readTable(productTypesTable);

            final item = ProductItemEntity(
              id: itemRow.id,
              name: itemRow.name,
              productCategoryId: itemRow.productCategoryId.id,
              productTypeId: itemRow.productType,
              createdAt: itemRow.createdAt,
            );

            final type = ProductTypeEntity(
              id: typeRow.id,
              name: typeRow.name,
              productCategoryId: typeRow.productCategory.id,
              createdAt: typeRow.createdAt,
              isCustom: typeRow.isCustom,
              productType: typeRow.productType?.id ?? ProductType.other.id,
            );

            return ProductItemWithTypeEntity(productItem: item, productType: type);
          }).toList(),
        );
  }
}
