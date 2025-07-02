import 'package:flutter/material.dart';
import 'package:groceryhelper/core/dialogs/state_dialog_manager.dart';
import 'package:groceryhelper/core/dialogs/generic_dialog.dart';
import 'package:groceryhelper/core/dialogs/loading_dialog.dart';
import 'package:groceryhelper/core/dialogs/success_dialog.dart';
import 'package:groceryhelper/core/dialogs/error_dialog.dart';
import 'package:groceryhelper/core/services/talker_service.dart';

class NewDialogService {
  static final NewDialogService _instance = NewDialogService._internal();
  factory NewDialogService() => _instance;
  NewDialogService._internal();

  static NewDialogService get instance => _instance;

  final StateDialogManager _stateManager = StateDialogManager();

  /// Показать диалог загрузки
  void showLoading(BuildContext context, String text) {
    TalkerService.log('NewDialogService: showLoading: $text');
    _stateManager.showLoading(context, text);
  }

  /// Показать диалог успеха
  Future<void> showSuccess(BuildContext context, String message, {String title = 'Success'}) async {
    TalkerService.log('NewDialogService: showSuccess: $message');
    await _stateManager.showSuccess(context, message, title: title);
  }

  /// Показать диалог ошибки
  Future<void> showError(BuildContext context, String message) async {
    TalkerService.log('NewDialogService: showError: $message');
    await _stateManager.showError(context, message);
  }

  /// Показать диалог подтверждения с одной кнопкой
  Future<void> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = 'OK',
  }) async {
    TalkerService.log('NewDialogService: showConfirmDialog: $title');
    await showGenericDialog(context: context, title: title, message: message, optionsBuilder: () => {buttonText: null});
  }

  /// Показать диалог подтверждения с двумя кнопками
  Future<bool?> showConfirmCancelDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmButtonText = 'Подтвердить',
    String cancelButtonText = 'Отмена',
  }) async {
    TalkerService.log('NewDialogService: showConfirmCancelDialog: $title');
    return showGenericDialog<bool>(
      context: context,
      title: title,
      message: message,
      optionsBuilder: () => {cancelButtonText: false, confirmButtonText: true},
    );
  }

  /// Показать кастомный диалог с произвольными опциями
  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    required String title,
    required String message,
    required Map<String, T?> options,
  }) async {
    TalkerService.log('NewDialogService: showCustomDialog: $title');
    return showGenericDialog<T>(context: context, title: title, message: message, optionsBuilder: () => options);
  }

  /// Очистить все диалоги
  void dispose() {
    _stateManager.dispose();
  }
}
