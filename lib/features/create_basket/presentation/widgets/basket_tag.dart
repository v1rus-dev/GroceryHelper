import 'package:design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:groceryhelper/shared/constants/app_assets.dart';

class BasketTag extends StatelessWidget {
  const BasketTag({
    super.key,
    required this.controller,
    required this.tags,
    required this.onAddTag,
    required this.onRemoveTag,
  });

  final TextEditingController controller;
  final List<String> tags;
  final Function(String) onAddTag;
  final Function(String) onRemoveTag;

  void _onAddTag(String tag) {
    if (tag.isNotEmpty && !tags.map((e) => e.toLowerCase()).contains(tag.toLowerCase())) {
      onAddTag(tag);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text('Добавьте теги', style: theme.textTheme.titleMedium),
            const Gap(4),
            Text('(Опционально)', style: theme.textTheme.titleMedium?.copyWith(color: context.theme.secondaryText)),
          ],
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: AppTextField(hintText: 'Название корзины', onChanged: (value) {}, controller: controller),
            ),
            const Gap(12),
            SizedBox(
              width: 56,
              height: 56,
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: context.theme.basket,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => _onAddTag(controller.text),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.icAdd,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
