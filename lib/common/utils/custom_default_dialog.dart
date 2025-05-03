import 'package:flutter/material.dart';

class CustomDefaultDialog {
  final BuildContext context;
  final DialogType dialogType;
  final AnimType animType;
  final String? title;
  final String? desc;
  final Widget? body;
  final Widget? btnOk;
  final Widget? btnCancel;
  final VoidCallback? btnOkOnPress;
  final VoidCallback? btnCancelOnPress;
  final Color? btnOkColor;
  final Color? btnCancelColor;
  final bool dismissOnTouchOutside;

  CustomDefaultDialog({
    required this.context,
    this.dialogType = DialogType.info,
    this.animType = AnimType.scale,
    this.title,
    this.desc,
    this.body,
    this.btnOk,
    this.btnCancel,
    this.btnOkOnPress,
    this.btnCancelOnPress,
    this.btnOkColor,
    this.btnCancelColor,
    this.dismissOnTouchOutside = true,
  });

  void show() {
    showGeneralDialog(
      context: context,
      barrierDismissible: dismissOnTouchOutside,
      barrierLabel: '',
      transitionDuration: _getAnimationDuration(),
      pageBuilder: (_, __, ___) => const SizedBox(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: _getAnimationCurve(),
          ),
          child: _buildDialogContent(),
        );
      },
    );
  }

  Widget _buildDialogContent() {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (body != null)
              body!
            else
              Column(
                children: [
                  _buildIcon(),
                  const SizedBox(height: 16),
                  if (title != null)
                    Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (desc != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      desc!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ],
              ),
            const SizedBox(height: 24),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final iconData = _getIconData();
    final color = _getIconColor();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(iconData, size: 36, color: color),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (btnCancel != null || btnCancelOnPress != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: btnCancelColor ?? Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: btnCancelOnPress,
                child: btnCancel ?? const Text('Cancel'),
              ),
            ),
          ),
        if (btnOk != null || btnOkOnPress != null)
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btnOkColor ?? _getIconColor(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: btnOkOnPress,
              child: btnOk ?? const Text('OK'),
            ),
          ),
      ],
    );
  }

  IconData _getIconData() {
    switch (dialogType) {
      case DialogType.success:
        return Icons.check_circle;
      case DialogType.error:
        return Icons.error;
      case DialogType.warning:
        return Icons.warning;
      case DialogType.info:
      default:
        return Icons.info;
    }
  }

  Color _getIconColor() {
    switch (dialogType) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return Colors.red;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.info:
      default:
        return Colors.blue;
    }
  }

  Duration _getAnimationDuration() {
    switch (animType) {
      case AnimType.scale:
        return const Duration(milliseconds: 600);
      case AnimType.slideLeft:
      case AnimType.slideRight:
      case AnimType.slideTop:
      case AnimType.slideBottom:
        return const Duration(milliseconds: 700);
    }
  }

  Curve _getAnimationCurve() {
    switch (animType) {
      case AnimType.scale:
        return Curves.easeInOutBack;
      case AnimType.slideLeft:
      case AnimType.slideRight:
      case AnimType.slideTop:
      case AnimType.slideBottom:
        return Curves.easeInOutQuart;
    }
  }
}

enum DialogType {
  info,
  success,
  warning,
  error,
}

enum AnimType {
  scale,
  slideLeft,
  slideRight,
  slideTop,
  slideBottom,
}
