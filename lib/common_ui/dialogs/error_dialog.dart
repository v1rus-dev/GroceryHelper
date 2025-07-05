import 'package:flutter/widgets.dart';
import 'package:groceryhelper/common_ui/dialogs/state_dialog_manager.dart';

Future<void> showErrorDialog(BuildContext context, String text) async {
  await StateDialogManager().showConfirmDialog(text, title: 'Error', optionsBuilder: () => {'Ok': null});
}
