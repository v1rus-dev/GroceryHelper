import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groceryhelper/core/utils/extentions/color_extensions.dart';
import 'package:web/web.dart' as html;

class WebHelpers {
  static bool isRunningAsPwa() {
    if (!kIsWeb) return false;
    final displayMode = html.window.matchMedia('(display-mode: standalone)');
    final isStandalone = displayMode.matches;
    return isStandalone;
  }

  static void setThemeColor(Color color) {
    if (!kIsWeb) return;
    final metaTag = html.document.querySelector('#theme-color-meta');
    if (metaTag != null) {
      metaTag.setAttribute('content', color.toHex());
    }
  }
}
