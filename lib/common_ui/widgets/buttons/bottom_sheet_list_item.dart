import 'package:flutter/material.dart';
import 'package:groceryhelper/common_ui/theme/app_theme_extension.dart';

class BottomSheetListItem extends StatefulWidget {
  BottomSheetListItem({super.key, required this.label, this.onTap, this.showDivider = true});
  final String label;
  final bool showDivider;
  VoidCallback? onTap;

  @override
  State<BottomSheetListItem> createState() => _BottomSheetListItemState();
}

class _BottomSheetListItemState extends State<BottomSheetListItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(widget.label, style: Theme.of(context).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
        if (widget.showDivider) Divider(color: context.theme.divider, height: 1, thickness: 1),
      ],
    );
  }
}
