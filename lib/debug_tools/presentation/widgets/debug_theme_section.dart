import 'package:flutter/material.dart' hide ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceryhelper/common_ui/theme/app_text_styles.dart';
import 'package:groceryhelper/common_ui/theme/bloc/theme_bloc.dart';

class DebugThemeSection extends StatelessWidget {
  const DebugThemeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Тема', style: AppTextStyles.headline2),
            const SizedBox(height: 8),
            Text('Текущая тема: ${state.isDark ? "Темная" : "Светлая"}', style: AppTextStyles.body),
            Text('Режим: ${_getThemeModeText(state.themeMode)}', style: AppTextStyles.body),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<ThemeBloc>().add(ThemeToggleEvent());
              },
              child: const Text('Переключить тему'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ThemeSetEvent(ThemeMode.light));
                    },
                    child: const Text('Светлая'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ThemeSetEvent(ThemeMode.dark));
                    },
                    child: const Text('Темная'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ThemeBloc>().add(ThemeSetEvent(ThemeMode.system));
                    },
                    child: const Text('Системная'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  String _getThemeModeText(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Светлая';
      case ThemeMode.dark:
        return 'Темная';
      case ThemeMode.system:
        return 'Системная';
    }
  }
}
