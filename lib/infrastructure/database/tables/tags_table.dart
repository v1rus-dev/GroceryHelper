import 'package:drift/drift.dart';

class TagsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  String get tableName => 'tags_table';
}
