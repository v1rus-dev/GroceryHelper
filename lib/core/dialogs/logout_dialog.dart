import 'package:flutter/widgets.dart';
import 'package:groceryhelper/core/dialogs/state_dialog_manager.dart';

Future<bool> showLogoutDialog(BuildContext context) async {
  final result = await StateDialogManager().showConfirmDialog<bool>(
    'Are you sure you want to logout?',
    title: 'Logout',
    optionsBuilder: () => {'Cancel': false, 'Logout': true},
  );
  return result ?? false;
}
