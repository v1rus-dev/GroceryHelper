import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/domain/enums/units.dart';
import 'package:groceryhelper/features/product_item/presentation/bottom_sheets/select_unit.dart';

class UnitsPart extends StatelessWidget {
  const UnitsPart({super.key, this.selectedUnit});

  final Units? selectedUnit;

  String? get displayName => selectedUnit?.displayName;

  _onTypeTap(BuildContext context) async {
    final result = await showModalBottomSheet(
      backgroundColor: context.theme.background,
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => SelectUnit(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Категория и тип", style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropDownButton(label: displayName, hintText: "Единица измерения", onTap: () => _onTypeTap(context)),
      ],
    );
  }
}
