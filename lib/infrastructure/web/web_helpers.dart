import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:web/web.dart' as html;

export 'web_helpers_stub.dart' if (dart.library.html) 'web_helpers_web.dart';

class WebHelpers {
  static bool isRunningAsPwa() {
    if (!kIsWeb) return false;

    // final displayMode = html.window.matchMedia('(display-mode: standalone)');
    // final isStandalone = displayMode.matches;

    return false;
  }

  static void setThemeColor(Color color) {
    if (!kIsWeb) return;
    // final metaTag = html.document.querySelector('#theme-color-meta');

    // if (metaTag != null) {
    //   print('setThemeColor: ${color.toHex()}');
    //   metaTag.setAttribute('content', color.toHex());
    // }
  }
}
