import 'package:flutter/material.dart';
import 'package:groceryhelper/app/setup/setup_firebase.dart';
import 'package:groceryhelper/app/setup/setup_locator.dart';
import 'package:groceryhelper/app/setup/setup_logging.dart';
import 'package:groceryhelper/app/setup/setup_preferences.dart';
import 'package:groceryhelper/app/setup/setup_database.dart';

Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupFirebase();
  setupLogging();
  await setupPreferences();
  final database = await setupDatabase();
  await setupLocator(database);
}
