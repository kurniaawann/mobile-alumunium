import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class CustomDetailChip extends StatelessWidget {
  const CustomDetailChip(
      {super.key,
      required this.icon,
      required this.text,
      this.isHighlighted = false});

  final IconData icon;
  final String text;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.warningColor.withOpacity(0.1)
            : AppColors.primaryGreyColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isHighlighted
              ? AppColors.warningColor.withOpacity(0.4)
              : AppColors.primaryGreyColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 16,
              color: isHighlighted
                  ? AppColors.warningColor
                  : AppColors.textSecondary),
          const SizedBox(width: 6),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isHighlighted
                      ? AppColors.primaryDarkColor
                      : AppColors.textPrimary,
                ),
          ),
        ],
      ),
    );
  }
}
