import 'package:flutter/material.dart';
import 'package:design/design.dart';

class OrPart extends StatelessWidget {
  const OrPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: context.theme.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text('или', style: AppTextStyles.body.copyWith(color: context.theme.secondaryText)),
        ),
        Expanded(child: Divider(color: context.theme.divider)),
      ],
    );
  }
}
