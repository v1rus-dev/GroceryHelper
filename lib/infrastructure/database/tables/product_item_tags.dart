import 'package:drift/drift.dart';

class ProductItemTags extends Table {
  IntColumn get productItemId => integer().customConstraint('REFERENCES product_items(id)')();
  IntColumn get tagId => integer().customConstraint('REFERENCES tags(id)')();

  @override
  Set<Column> get primaryKey => {productItemId, tagId};
}
