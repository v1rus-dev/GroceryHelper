import 'package:groceryhelper/infrastructure/database/app_database.dart';

Future<AppDatabase> setupDatabase() async {
  final database = AppDatabase();
  await database.initializeDatabase();
  return database;
}
