import 'package:drift/drift.dart';
import 'package:groceryhelper/infrastructure/database/converters/product_category_converter.dart';
import 'package:groceryhelper/infrastructure/database/converters/product_type_converter.dart';

class ProductTypesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get productCategory => integer().map(const ProductCategoryConverter())();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isCustom => boolean().withDefault(const Constant(true))();
  IntColumn get productType => integer().map(const ProductTypeConverter()).nullable()();

  @override
  String get tableName => 'product_types_table';
}
