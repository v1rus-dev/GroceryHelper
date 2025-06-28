import 'package:flutter/material.dart';
import 'package:groceryhelper/core/widgets/app_scaffold.dart';
import 'package:groceryhelper/core/widgets/toolbars/app_toolbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Настройки', withBackButton: true),
      body: Column(),
    );
  }
}
