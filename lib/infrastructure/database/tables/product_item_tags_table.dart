import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/tables/product_items_table.dart';
import 'package:groceryhelper/infrastructure/database/tables/tags_table.dart';

class ProductItemTagsTable extends Table {
  IntColumn get productItemId => integer().references(ProductItemsTable, #id)();
  IntColumn get tagId => integer().references(TagsTable, #id)();

  @override
  Set<Column> get primaryKey => {productItemId, tagId};

  @override
  String get tableName => 'product_item_tags_table';
}
