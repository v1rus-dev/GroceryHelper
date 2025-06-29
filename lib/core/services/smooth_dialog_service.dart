import 'package:flutter/material.dart';
import 'package:groceryhelper/core/smooth_dialogs/base_smooth_dialog.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dialog.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dualog_confirm.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_loading_dialog.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/core/services/global_key_service.dart';

class SmoothDialogService {
  static final SmoothDialogService _instance = SmoothDialogService._internal();
  factory SmoothDialogService() => _instance;
  SmoothDialogService._internal();

  static SmoothDialogService get instance => _instance;

  // Отслеживание текущего диалога
  SmoothDialog? _currentDialog;
  bool _isDialogShowing = false;
  final GlobalKey<BaseSmoothDialogState> _dialogKey = GlobalKey<BaseSmoothDialogState>();

  /// Получить текущий контекст из GlobalKeyService
  BuildContext? get context => GlobalKeyService.instance.context;

  /// Получить navigatorKey из GlobalKeyService
  GlobalKey<NavigatorState> get navigatorKey => GlobalKeyService.instance.navigatorKey;

  /// Показать smooth диалог загрузки
  Future<void> showLoading() async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showLoading: context is null');
      return;
    }

    final loadingDialog = SmoothLoadingDialog();
    _showDialog(loadingDialog);
  }

  /// Показать smooth диалог загрузки с текстом
  Future<void> showLoadingWithText(String text) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showLoadingWithText: context is null');
      return;
    }

    final loadingDialog = SmoothLoadingDialog(text: text);
    _showDialog(loadingDialog);
  }

  /// Показать smooth диалог с одной кнопкой подтверждения
  Future<bool?> showConfirmDialog({required String title, required String message, String? confirmButtonText}) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showConfirmDialog: context is null');
      return null;
    }

    final confirmDialog = SmoothDialogConfirm(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText ?? 'OK',
      cancelButtonText: 'OK',
    );
    return _showBoolDialog(confirmDialog);
  }

  /// Показать smooth диалог с кнопками подтверждения и отмены
  Future<bool?> showConfirmCancelDialog({
    required String title,
    required String message,
    String? confirmButtonText,
    String? cancelButtonText,
  }) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showConfirmCancelDialog: context is null');
      return null;
    }

    final confirmCancelDialog = SmoothDialogConfirm(
      title: title,
      message: message,
      confirmButtonText: confirmButtonText ?? 'Подтвердить',
      cancelButtonText: cancelButtonText ?? 'Отмена',
    );
    return _showBoolDialog(confirmCancelDialog);
  }

  /// Показать кастомный smooth диалог
  Future<dynamic> showCustomDialog(SmoothDialog dialog) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showCustomDialog: context is null');
      return null;
    }

    return _showDialog(dialog);
  }

  /// Обновить текущий smooth диалог с анимацией
  Future<dynamic> updateDialog(SmoothDialog newDialog) async {
    TalkerService.log('SmoothDialogService: updateDialog: start');
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: updateDialog: context is null');
      return;
    }

    if (!_isDialogShowing) {
      // Если нет текущего диалога, просто показываем новый
      return _showDialog(newDialog);
    }

    // Если диалог уже показывается, обновляем его содержимое
    TalkerService.log('SmoothDialogService: updateDialog: update existing dialog');
    _currentDialog = newDialog;

    // Обновляем существующий диалог через setState
    _dialogKey.currentState?.updateDialog(newDialog);
  }

  /// Закрыть текущий smooth диалог
  void closeDialog() {
    final context = GlobalKeyService.instance.context;
    if (context != null && _isDialogShowing) {
      Navigator.of(context).pop();
      _currentDialog = null;
      _isDialogShowing = false;
    }
  }

  /// Получить текущий smooth диалог (если есть)
  SmoothDialog? get currentDialog => _currentDialog;

  /// Проверить, показывается ли smooth диалог
  bool get isDialogShowing => _isDialogShowing;

  /// Показать smooth диалог с ошибкой
  Future<bool?> showErrorDialog({
    required String title,
    required String message,
    String? retryButtonText,
    String? closeButtonText,
    VoidCallback? onRetry,
  }) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showErrorDialog: context is null');
      return null;
    }

    final errorDialog = SmoothDialogConfirm(
      title: title,
      message: message,
      confirmButtonText: retryButtonText ?? 'Попробовать еще',
      cancelButtonText: closeButtonText ?? 'Закрыть',
    );
    return _showBoolDialog(errorDialog);
  }

  /// Показать простой smooth диалог с информацией
  Future<void> showInfoDialog({required String title, required String message, String? buttonText}) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) {
      TalkerService.log('SmoothDialogService: showInfoDialog: context is null');
      return;
    }

    final infoDialog = SmoothDialogConfirm(
      title: title,
      message: message,
      confirmButtonText: buttonText ?? 'OK',
      cancelButtonText: buttonText ?? 'OK',
    );
    _showDialog(infoDialog);
  }

  /// Внутренний метод для показа диалога
  Future<dynamic> _showDialog(SmoothDialog dialog) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) return null;

    _currentDialog = dialog;
    _isDialogShowing = true;

    return showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseSmoothDialog(key: _dialogKey, dialog: dialog);
      },
    );
  }

  /// Внутренний метод для показа диалога с возвратом bool
  Future<bool?> _showBoolDialog(SmoothDialog dialog) async {
    final context = GlobalKeyService.instance.context;
    if (context == null) return null;

    _currentDialog = dialog;
    _isDialogShowing = true;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BaseSmoothDialog(key: _dialogKey, dialog: dialog);
      },
    );
  }
}
