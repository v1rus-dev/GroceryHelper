import 'package:flutter/material.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/app/router/app_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppToolbar(title: 'Настройки', withBackButton: true, onBackPressed: () => appRouter.pop()),
      body: Column(),
    );
  }
}
