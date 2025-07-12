import 'dart:io';

import '../../domain/enums/product_category.dart';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'tables/product_item_tags.dart';
import 'tables/product_items.dart';
import 'tables/product_types.dart';
import 'tables/tags_table.dart';
import 'converters/product_category_converter.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ProductItems, ProductItemTags, TagsTable, ProductTypes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File('${dbFolder.path}/db.sqlite');
    return NativeDatabase(file);
  });
}
