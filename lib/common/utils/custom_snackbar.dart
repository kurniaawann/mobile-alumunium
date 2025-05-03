import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ViewCustomSnackBar {
  static void showError(
    BuildContext context,
    String errorMessage,
  ) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        iconRotationAngle: 0,
        messagePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
        backgroundColor: AppColors.errorColor,
        iconPositionLeft: 2,
        textAlign: TextAlign.center,
        message: errorMessage,
      ),
    );
  }
}
