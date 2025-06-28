import 'package:flutter/material.dart';
import 'package:groceryhelper/core/utils/debug/presentation/widgets/utils/debug_drawer.dart';

class DebugWrapper extends StatelessWidget {
  final Widget child;

  const DebugWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [child, const DebugDrawer()]);
  }
}
