import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:design/design.dart';
import 'package:groceryhelper/domain/enums/product_category.dart';
import 'package:design/widgets/utils/drag_handler.dart';

class AddCustomTypeBottomSheet extends StatefulWidget {
  const AddCustomTypeBottomSheet({super.key, required this.selectedCategory});

  final ProductCategory selectedCategory;

  @override
  State<AddCustomTypeBottomSheet> createState() => _AddCustomTypeBottomSheetState();
}

class _AddCustomTypeBottomSheetState extends State<AddCustomTypeBottomSheet> {
  final TextEditingController _nameController = TextEditingController();

  void _onAdd(BuildContext context) {
    final name = _nameController.text;
    if (name.isEmpty) return;

    context.pop(name);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DragHandler(),
          const Gap(4),
          Text('Добавление типа товара', style: Theme.of(context).textTheme.displayMedium),
          const Gap(16),
          Text(
            'Вы добавляете новый тип товара для категории:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Gap(8),
          AppChip(label: widget.selectedCategory.displayName, color: widget.selectedCategory.color, isSelected: true),
          const Gap(8),
          Text(
            'Пожалуйста, введите название нового типа товара в поле ниже.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Gap(12),
          AppTextField(controller: _nameController, labelText: 'Название типа'),
          const Gap(20),
          SafeArea(
            child: AppPrimaryButton(onPressed: () => _onAdd(context), text: "Добавить"),
          ),
        ],
      ),
    );
  }
}
