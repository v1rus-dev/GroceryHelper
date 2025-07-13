import 'dart:io';

import '../../domain/enums/product_category.dart';
import '../../domain/enums/product_type.dart';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'tables/product_item_tags_table.dart';
import 'tables/product_items_table.dart';
import 'tables/product_types_table.dart';
import 'tables/tags_table.dart';
import 'converters/product_category_converter.dart';
import 'converters/product_type_converter.dart';
import 'database_initializer.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ProductItemsTable, ProductItemTagsTable, TagsTable, ProductTypesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Инициализирует базу данных при первом запуске
  Future<void> initializeDatabase() async {
    final initializer = DatabaseInitializer(this);
    await initializer.initializeIfNeeded();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/db.sqlite');
    return NativeDatabase(file);
  });
}
