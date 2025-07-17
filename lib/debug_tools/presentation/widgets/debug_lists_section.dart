import 'package:flutter/material.dart';
import 'package:design/design.dart';

class DebugListsSection extends StatelessWidget {
  const DebugListsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Списки', style: AppTextStyles.headline2),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(backgroundColor: AppColors.primaryLight, child: Text('${index + 1}')),
              title: Text('Элемент ${index + 1}'),
              subtitle: Text('Описание элемента ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios),
            );
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
