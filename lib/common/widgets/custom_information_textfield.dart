import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class CustomInformationTextfield extends StatelessWidget {
  const CustomInformationTextfield({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 18, color: AppColors.warningColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primaryDarkColor,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
