import 'package:flutter/material.dart';

abstract class SmoothDialog {
  Widget buildContent(BuildContext context) => const SizedBox.shrink();

  double get width => 350;

  double get height => 200;

  double get borderRadius => 16;

  double get padding => 16;
}
