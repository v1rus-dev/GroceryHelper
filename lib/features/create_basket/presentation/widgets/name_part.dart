import 'package:basket_icon_kit/basket_icon_kit.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/basket_icon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NamePart extends StatelessWidget {
  const NamePart({
    super.key,
    required this.selectedIcon,
    required this.selectedIconColor,
    required this.nameController,
  });

  final DefaultIconSet selectedIcon;
  final Color selectedIconColor;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 56,
          height: 56,
          child: BasketIcon(
            backgroundColor: selectedIconColor,
            iconColor: Colors.white,
            icon: selectedIcon.path,
            package: BasketIcons.package,
          ),
        ),
        const Gap(12),
        Expanded(
          child: AppTextField(hintText: 'Название корзины', onChanged: (value) {}, controller: nameController),
        ),
      ],
    );
  }
}
