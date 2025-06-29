import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/dialogs.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

class DialogService {
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;
  DialogService._internal();

  static DialogService get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  // Отслеживание текущего диалога
  Widget? _currentDialog;
  bool _isDialogShowing = false;

  /// Получить текущий контекст из navigatorKey
  BuildContext? get context => _navigatorKey.currentContext;

  /// Показать диалог загрузки без текста
  Future<void> showLoading() async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      return;
    }

    final loadingDialog = const LoadingDialog();
    _currentDialog = loadingDialog;
    _isDialogShowing = true;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedDialogWrapper(child: loadingDialog);
      },
    );
  }

  /// Показать диалог загрузки с текстом
  Future<void> showLoadingWithText(String text) async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: showLoadingWithText: context is null');
      return;
    }

    final loadingDialog = LoadingWithTextDialog(text: text);
    _currentDialog = loadingDialog;
    _isDialogShowing = true;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedDialogWrapper(child: loadingDialog);
      },
    );
  }

  /// Показать диалог с одной кнопкой подтверждения
  Future<bool?> showConfirmDialog({required String title, required String message, String? confirmButtonText}) async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: showConfirmDialog: context is null');
      return null;
    }

    final confirmDialog = ConfirmDialog(title: title, message: message, confirmButtonText: confirmButtonText ?? 'OK');
    _currentDialog = confirmDialog;
    _isDialogShowing = true;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedDialogWrapper(child: confirmDialog);
      },
    );
  }

  /// Показать диалог с кнопками подтверждения и отмены
  Future<bool?> showConfirmCancelDialog({
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
  }) async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: showConfirmCancelDialog: context is null');
      return null;
    }

    final confirmCancelDialog = ConfirmCancelDialog(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText ?? 'Подтвердить',
      cancelButtonText: cancelButtonText ?? 'Отмена',
    );
    _currentDialog = confirmCancelDialog;
    _isDialogShowing = true;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedDialogWrapper(child: confirmCancelDialog);
      },
    );
  }

  /// Обновить текущий диалог с анимацией
  Future<dynamic> updateDialog(Widget newDialog) async {
    TalkerService.log('DialogService: updateDialog: start');
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: updateDialog: context is null');
      return;
    }

    final oldDialog = _currentDialog;
    _currentDialog = newDialog;

    if (!_isDialogShowing || oldDialog == null) {
      // Если нет текущего диалога, просто показываем новый
      _isDialogShowing = true;
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AnimatedDialogWrapper(child: newDialog);
        },
      );
    }

    TalkerService.log('DialogService: updateDialog: update dialog with animation');
    // Обновляем диалог с анимацией
    Navigator.of(context).pop();
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AnimatedDialogTransition(
          fromDialog: AnimatedDialogWrapper(child: oldDialog),
          toDialog: AnimatedDialogWrapper(child: newDialog),
        );
      },
    );
  }

  /// Закрыть текущий диалог
  void closeDialog() {
    final context = _navigatorKey.currentContext;
    if (context != null && _isDialogShowing) {
      Navigator.of(context).pop();
      _currentDialog = null;
      _isDialogShowing = false;
    }
  }

  /// Получить текущий диалог (если есть)
  Widget? get currentDialog => _currentDialog;

  /// Проверить, показывается ли диалог
  bool get isDialogShowing => _isDialogShowing;

  /// Показать диалог с ошибкой и двумя кнопками (для обратной совместимости)
  Future<bool?> showErrorDialog({
    required String title,
    required String message,
    String? retryButtonText,
    String? closeButtonText,
    VoidCallback? onRetry,
  }) async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: showErrorDialog: context is null');
      return null;
    }

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ErrorDialog(
          title: title,
          message: message,
          retryButtonText: retryButtonText ?? 'Попробовать еще',
          closeButtonText: closeButtonText ?? 'Закрыть',
          onRetry: onRetry,
        );
      },
    );
  }

  /// Показать простой диалог с информацией (для обратной совместимости)
  Future<void> showInfoDialog({required String title, required String message, String? buttonText}) async {
    final context = _navigatorKey.currentContext;
    if (context == null) {
      TalkerService.log('DialogService: showInfoDialog: context is null');
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(buttonText ?? 'OK'))],
        );
      },
    );
  }
}
