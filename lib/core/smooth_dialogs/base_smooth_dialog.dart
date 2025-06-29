import 'package:flutter/material.dart';
import 'package:groceryhelper/core/smooth_dialogs/smooth_dialog.dart';

class BaseSmoothDialog extends StatefulWidget {
  const BaseSmoothDialog({super.key, required this.dialog});

  final SmoothDialog dialog;

  @override
  State<BaseSmoothDialog> createState() => _BaseSmoothDialogState();
}

class _BaseSmoothDialogState extends State<BaseSmoothDialog> {
  Widget _content = const SizedBox.shrink();
  double _width = 0;
  double _height = 0;
  double _borderRadius = 0;
  bool _isInitialized = false;
  bool _isUpdating = false;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    _width = widget.dialog.width;
    _height = widget.dialog.height;
    _borderRadius = widget.dialog.borderRadius;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _updateContent(isFirstShow: true);
      _isInitialized = true;
    }
  }

  @override
  void didUpdateWidget(covariant BaseSmoothDialog oldWidget) {
    if (oldWidget.dialog != widget.dialog) {
      _updateContent(isFirstShow: false, oldDialog: oldWidget.dialog);
    }
    super.didUpdateWidget(oldWidget);
  }

  void _updateContent({bool isFirstShow = false, SmoothDialog? oldDialog}) {
    if (!mounted || _isUpdating) return;
    _isUpdating = true;

    // Первый показ — всегда без задержки
    if (isFirstShow) {
      setState(() {
        _content = widget.dialog.buildContent(context);
        _width = widget.dialog.width;
        _height = widget.dialog.height;
        _borderRadius = widget.dialog.borderRadius;
        _showContent = true;
        _isUpdating = false;
      });
      return;
    }

    // Проверяем, меняются ли размеры
    final bool sizeChanged =
        oldDialog == null ||
        oldDialog.width != widget.dialog.width ||
        oldDialog.height != widget.dialog.height ||
        oldDialog.borderRadius != widget.dialog.borderRadius;

    if (sizeChanged) {
      // Скрываем контент перед изменением размеров
      setState(() {
        _showContent = false;
      });
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _width = widget.dialog.width;
            _height = widget.dialog.height;
            _borderRadius = widget.dialog.borderRadius;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              setState(() {
                _content = widget.dialog.buildContent(context);
                _showContent = true;
                _isUpdating = false;
              });
            }
          });
        }
      });
    } else {
      // Размеры не меняются — обновляем контент мгновенно
      setState(() {
        _content = widget.dialog.buildContent(context);
        _showContent = true;
        _isUpdating = false;
      });
    }
  }

  /// Метод для обновления диалога извне
  void updateDialog(SmoothDialog newDialog) {
    if (!mounted || _isUpdating) return;
    _isUpdating = true;
    // Проверяем, меняются ли размеры
    final bool sizeChanged =
        newDialog.width != _width || newDialog.height != _height || newDialog.borderRadius != _borderRadius;

    if (sizeChanged) {
      setState(() {
        _showContent = false;
      });
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted) {
          setState(() {
            _width = newDialog.width;
            _height = newDialog.height;
            _borderRadius = newDialog.borderRadius;
          });
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              setState(() {
                _content = newDialog.buildContent(context);
                _showContent = true;
                _isUpdating = false;
              });
            }
          });
        }
      });
    } else {
      setState(() {
        _content = newDialog.buildContent(context);
        _showContent = true;
        _isUpdating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: _width,
          height: _height,
          constraints: BoxConstraints(minWidth: _width, minHeight: _height, maxWidth: _width, maxHeight: _height),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(_borderRadius),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _showContent ? 1.0 : 0.0,
              child: _content,
            ),
          ),
        ),
      ),
    );
  }
}

// Экспортируем State класс для использования в SmoothDialogService
typedef BaseSmoothDialogState = _BaseSmoothDialogState;
