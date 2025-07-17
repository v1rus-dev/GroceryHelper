import 'package:flutter/material.dart';

extension ColorExtensions on Color {
  String toHex() {
    int a = (this.a * 255.0).round() & 0xff;
    int r = (this.r * 255.0).round() & 0xff;
    int g = (this.g * 255.0).round() & 0xff;
    int b = (this.b * 255.0).round() & 0xff;
    return '#'
        '${a.toRadixString(16).padLeft(2, '0')}'
        '${r.toRadixString(16).padLeft(2, '0')}'
        '${g.toRadixString(16).padLeft(2, '0')}'
        '${b.toRadixString(16).padLeft(2, '0')}';
  }
}
