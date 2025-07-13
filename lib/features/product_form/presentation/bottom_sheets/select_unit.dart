import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/bottom_sheet_list_item.dart';
import 'package:groceryhelper/common_ui/widgets/utils/drag_handler.dart';
import 'package:groceryhelper/domain/enums/units.dart';

class SelectUnit extends StatefulWidget {
  const SelectUnit({super.key});

  @override
  State<SelectUnit> createState() => _SelectUnitState();
}

class _SelectUnitState extends State<SelectUnit> {
  _onSelectUnit(BuildContext context, Units unit) {
    context.pop(unit);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      snap: true,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(color: theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              DragHandler(),
              const Gap(8),
              Center(child: Text('Единица измерения', style: theme.textTheme.displayMedium)),
              const Gap(12),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    ...Units.values.asMap().entries.map(
                      (item) => BottomSheetListItem(
                        key: Key(item.value.displayName),
                        label: item.value.displayName,
                        onTap: () => _onSelectUnit(context, item.value),
                        showDivider: item.key != Units.values.length - 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
