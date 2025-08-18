import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/color_icon.dart';

class BasketColors extends StatelessWidget {
  const BasketColors({super.key, required this.onColorSelected});

  final Function(Color) onColorSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Выберите цвет', style: theme.textTheme.titleMedium),
            ),
          ],
        ),
        const Gap(8),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            separatorBuilder: (context, index) => const Gap(12),
            itemCount: BasketColor.colors.length,
            itemBuilder: (context, index) => ColorIcon(color: BasketColor.colors[index], onTap: onColorSelected),
          ),
        ),
      ],
    );
  }
}
