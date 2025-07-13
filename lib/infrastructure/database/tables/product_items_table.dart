import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/converters/product_category_converter.dart';
import 'package:groceryhelper/infrastructure/database/tables/product_types_table.dart';

class ProductItemsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get productCategoryId => integer().map(const ProductCategoryConverter())();
  IntColumn get productType => integer().references(ProductTypesTable, #id)();
  IntColumn get itemId => integer().unique()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'product_items_table';
}
