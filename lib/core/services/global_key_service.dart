import 'package:flutter/material.dart';

class GlobalKeyService {
  static final GlobalKeyService _instance = GlobalKeyService._internal();
  factory GlobalKeyService() => _instance;
  GlobalKeyService._internal();

  static GlobalKeyService get instance => _instance;

  // Глобальный ключ для навигации
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Получить текущий контекст из navigatorKey
  BuildContext? get context => _navigatorKey.currentContext;

  /// Проверить, доступен ли контекст
  bool get hasContext => _navigatorKey.currentContext != null;
}
