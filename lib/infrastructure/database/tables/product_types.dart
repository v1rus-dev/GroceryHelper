import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/converters/product_category_converter.dart';

class ProductTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get productCategory => integer().map(const ProductCategoryConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
