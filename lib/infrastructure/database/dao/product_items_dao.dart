import 'package:drift/drift.dart';
import 'package:groceryhelper/domain/entities/product_item.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:groceryhelper/domain/enums/product_type.dart';
import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_db_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_item_with_type_db_entity.dart';
import 'package:groceryhelper/infrastructure/database/entities/product_type_db_entity.dart';
import 'package:groceryhelper/infrastructure/database/tables/product_items_table.dart';

part 'product_items_dao.g.dart';

@DriftAccessor(tables: [ProductItemsTable])
class ProductItemsDao extends DatabaseAccessor<AppDatabase> with _$ProductItemsDaoMixin {
  ProductItemsDao(super.db);

  Future<ProductItemWithTypeDbEntity> createProduct(ProductItem product) async {
    final companion = ProductItemsTableCompanion.insert(
      name: product.name,
      productCategoryId: product.category,
      productType: product.productTypeId,
    );

    final id = await into(productItemsTable).insert(companion);
    final productWithType = await getProductItemWithType(id);
    return productWithType;
  }

  Future<List<ProductItemWithTypeDbEntity>> getProductItems() async {
    final query = select(
      productItemsTable,
    ).join([innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id))]);
    final result = await query.get();
    return result.map((row) {
      final itemRow = row.readTable(productItemsTable);
      final typeRow = row.readTable(productTypesTable);

      final item = ProductItemDbEntity(
        id: itemRow.id,
        name: itemRow.name,
        productCategoryId: itemRow.productCategoryId.id,
        productTypeId: itemRow.productType,
        createdAt: itemRow.createdAt,
      );
      final type = ProductTypeDbEntity(
        id: typeRow.id,
        name: typeRow.name,
        productCategoryId: typeRow.productCategory.id,
        createdAt: typeRow.createdAt,
        isCustom: typeRow.isCustom,
        productType: typeRow.productType?.id ?? ProductType.other.id,
      );

      return ProductItemWithTypeDbEntity(productItem: item, productType: type);
    }).toList();
  }

  Stream<List<ProductItemWithTypeDbEntity>> watchProductItems() {
    return select(productItemsTable)
        .join([innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id))])
        .watch()
        .map(
          (event) => event.map((row) {
            final itemRow = row.readTable(productItemsTable);
            final typeRow = row.readTable(productTypesTable);

            final item = ProductItemDbEntity(
              id: itemRow.id,
              name: itemRow.name,
              productCategoryId: itemRow.productCategoryId.id,
              productTypeId: itemRow.productType,
              createdAt: itemRow.createdAt,
            );

            final type = ProductTypeDbEntity(
              id: typeRow.id,
              name: typeRow.name,
              productCategoryId: typeRow.productCategory.id,
              createdAt: typeRow.createdAt,
              isCustom: typeRow.isCustom,
              productType: typeRow.productType?.id ?? ProductType.other.id,
            );

            return ProductItemWithTypeDbEntity(productItem: item, productType: type);
          }).toList(),
        );
  }

  Future<ProductItemWithTypeDbEntity> getProductItemWithType(int id) async {
    final query = select(productItemsTable).join([
      innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id)),
    ])..where(productItemsTable.id.equals(id));
    final result = await query.getSingle();
    final itemRow = result.readTable(productItemsTable);
    final typeRow = result.readTable(productTypesTable);

    final item = ProductItemDbEntity(
      id: itemRow.id,
      name: itemRow.name,
      productCategoryId: itemRow.productCategoryId.id,
      productTypeId: itemRow.productType,
      createdAt: itemRow.createdAt,
    );

    final type = ProductTypeDbEntity(
      id: typeRow.id,
      name: typeRow.name,
      productCategoryId: typeRow.productCategory.id,
      createdAt: typeRow.createdAt,
      isCustom: typeRow.isCustom,
      productType: typeRow.productType?.id ?? ProductType.other.id,
    );

    return ProductItemWithTypeDbEntity(productItem: item, productType: type);
  }

  Future<List<ProductItemWithTypeDbEntity>> searchProducts(String searchQuery) async {
    final query = select(productItemsTable).join([
      innerJoin(productTypesTable, productItemsTable.productType.equalsExp(productTypesTable.id)),
    ])..where(productItemsTable.name.like('%$searchQuery%'));
    final result = await query.get();
    final products = result.map((row) {
      final itemRow = row.readTable(productItemsTable);
      final typeRow = row.readTable(productTypesTable);

      final item = ProductItemDbEntity(
        id: itemRow.id,
        name: itemRow.name,
        productCategoryId: itemRow.productCategoryId.id,
        productTypeId: itemRow.productType,
        createdAt: itemRow.createdAt,
      );

      final type = ProductTypeDbEntity(
        id: typeRow.id,
        name: typeRow.name,
        productCategoryId: typeRow.productCategory.id,
        createdAt: typeRow.createdAt,
        isCustom: typeRow.isCustom,
        productType: typeRow.productType?.id ?? ProductType.other.id,
      );

      return ProductItemWithTypeDbEntity(productItem: item, productType: type);
    }).toList();

    return products;
  }
}
