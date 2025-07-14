import 'package:groceryhelper/infrastructure/preferences/app_preferences.dart';

Future<void> setupPreferences() async {
  await AppPreferences.init();
}
