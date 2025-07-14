import 'package:groceryhelper/infrastructure/database/app_database.dart';
import 'package:groceryhelper/infrastructure/services/locator.dart';

Future<void> setupLocator(AppDatabase database) async {
  await initServiceLocator(database);
}
