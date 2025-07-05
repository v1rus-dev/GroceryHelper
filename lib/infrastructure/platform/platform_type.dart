import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformType {
  static bool get isWeb => kIsWeb;
  static bool get isIOS => !kIsWeb && Platform.isIOS;
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;
}
