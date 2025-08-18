import 'package:basket_icon_kit/basket_icon_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/features/create_basket/presentation/widgets/basket_icon.dart';

class SelectIconPart extends StatelessWidget {
  const SelectIconPart({
    super.key,
    required this.selectedIcon,
    required this.selectedColor,
    required this.onIconSelected,
  });

  final DefaultIconSet selectedIcon;
  final Color selectedColor;
  final Function(DefaultIconSet) onIconSelected;

  static const double _itemSize = 56.0;
  static const double _mainAxisSpacing = 10.0;
  static const Color _defaultIconColor = Color(0xFF2D264B);
  static const Color _defaultBackgroundColor = Color(0xFFBDBDBD);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Text('Выберите иконку', style: theme.textTheme.titleMedium)]),
        const Gap(8),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double availableWidth = constraints.maxWidth;
            final double minSpacing = 8.0;
            final int maxColumns = ((availableWidth + minSpacing) / (_itemSize + minSpacing)).floor();
            final int columns = maxColumns.clamp(1, DefaultIconSet.values.length);
            final double totalItemsWidth = _itemSize * columns;
            final double totalSpacing = availableWidth - totalItemsWidth;
            final double spacing = columns > 1 ? totalSpacing / (columns - 1) : 0;

            return Wrap(
              direction: Axis.horizontal,
              spacing: spacing,
              runSpacing: _mainAxisSpacing,
              children: DefaultIconSet.values
                  .map(
                    (e) => SizedBox(
                      width: _itemSize,
                      height: _itemSize,
                      child: BasketIcon(
                        key: ValueKey(e),
                        iconColor: selectedIcon == e ? Colors.white : _defaultIconColor,
                        backgroundColor: selectedIcon == e
                            ? selectedColor
                            : _defaultBackgroundColor.withValues(alpha: 0.1),
                        icon: e.path,
                        package: BasketIcons.package,
                        onTap: () => onIconSelected(e),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
