import 'package:flutter/material.dart';

class EmptyToolbarButton extends StatelessWidget {
  final double? width;
  final double? height;

  const EmptyToolbarButton({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 40, height: height ?? 40);
  }
}
