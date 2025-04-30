import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class CustomError extends StatelessWidget {
  const CustomError({super.key, required this.messageError});

  final String messageError;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.errorColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.errorColor,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppColors.primaryWhiteColor),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              messageError,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryWhiteColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
