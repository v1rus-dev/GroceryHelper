import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/converters/product_category_converter.dart';

class ProductItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get productCategoryId => integer().map(const ProductCategoryConverter())();
  IntColumn get itemId => integer()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
