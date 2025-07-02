import 'package:flutter/widgets.dart';
import 'package:groceryhelper/core/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(context: context, title: 'Error', message: text, optionsBuilder: () => {'Ok': null});
}
