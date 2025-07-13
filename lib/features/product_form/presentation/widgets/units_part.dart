import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';
import 'package:groceryhelper/common_ui/widgets/buttons/drop_down_button.dart';
import 'package:groceryhelper/domain/enums/units.dart';
import 'package:groceryhelper/features/product_form/presentation/bottom_sheets/select_unit.dart';

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
    // final result = await showModalBottomSheet(
    //   backgroundColor: context.theme.background,
    //   context: context,
    //   isScrollControlled: true,
    //   useSafeArea: true,
    //   builder: (context) => CategoryTypeScreen(selectedCategory: selectedCategory),
    // );
    // if (result is CategoryTypeResult) {
    //   onCategorySelected(result.category);
    //   onTypeSelected(result.type);
    // }
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
