import 'package:flutter/material.dart';

class GlobalContextService {
  GlobalContextService._();
  static final GlobalContextService instance = GlobalContextService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext? get context => navigatorKey.currentContext;
  NavigatorState? get navigator => navigatorKey.currentState;
}
