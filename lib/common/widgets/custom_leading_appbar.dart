import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class CustomLeadingAppbar extends StatelessWidget {
  const CustomLeadingAppbar({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Get.back(),
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      color: AppColors.primaryDarkColor,
    );
  }
}
