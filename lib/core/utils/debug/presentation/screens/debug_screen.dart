import 'package:flutter/material.dart';
import 'package:groceryhelper/core/theme/app_colors.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_headers_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_text_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_buttons_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_colors_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_cards_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_input_fields_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_lists_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_chips_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_progress_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_switches_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_icons_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_theme_section.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/debug_dialogs_section.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Screen'),
        backgroundColor: AppColors.primaryLight,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DebugHeadersSection(),
            const DebugTextSection(),
            const DebugButtonsSection(),
            const DebugColorsSection(),
            const DebugCardsSection(),
            const DebugInputFieldsSection(),
            const DebugListsSection(),
            const DebugChipsSection(),
            const DebugProgressSection(),
            const DebugSwitchesSection(),
            const DebugIconsSection(),
            const DebugThemeSection(),
            const DebugDialogsSection(),
          ],
        ),
      ),
    );
  }
}
