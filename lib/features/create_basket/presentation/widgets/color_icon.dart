import 'package:flutter/material.dart';

class ColorIcon extends StatelessWidget {
  const ColorIcon({super.key, required this.color, required this.onTap});

  final Color color;
  final Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => onTap(color),
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
