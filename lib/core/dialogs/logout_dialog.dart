import 'package:flutter/widgets.dart';
import 'package:groceryhelper/core/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Logout",
    message: "Are you sure you want to logout?",
    optionsBuilder: () => {'Cancel': false, 'Logout': true},
  ).then((value) => value ?? false);
}
