import 'package:flutter/material.dart';

class DialogService {
  static final DialogService _instance = DialogService._internal();
  factory DialogService() => _instance;
  DialogService._internal();

  static DialogService get instance => _instance;

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext? get _context => _navigatorKey.currentContext;

  /// Показать диалог с ошибкой и двумя кнопками
  Future<bool?> showErrorDialog({
    required String title,
    required String message,
    String? retryButtonText,
    String? closeButtonText,
    VoidCallback? onRetry,
  }) async {
    if (_context == null) return null;

    return showDialog<bool>(
      context: _context!,
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

  /// Показать простой диалог с информацией
  Future<void> showInfoDialog({
    required String title,
    required String message,  
    String? buttonText,
  }) async {
    if (_context == null) return;

    return showDialog<void>(
      context: _context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText ?? 'OK'),
            ),
          ],
        );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String retryButtonText;
  final String closeButtonText;
  final VoidCallback? onRetry;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    required this.retryButtonText,
    required this.closeButtonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            closeButtonText,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onRetry?.call();
          },
          child: Text(retryButtonText),
        ),
      ],
      actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
