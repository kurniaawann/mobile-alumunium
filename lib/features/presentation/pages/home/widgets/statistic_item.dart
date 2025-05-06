import 'package:flutter/material.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class StatisticItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final bool isWarning;

  const StatisticItem({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Modern color scheme
    final primaryColor =
        isWarning ? AppColors.errorColor : Color(0xFF4F46E5); // Indigo-600
    final bgColor = isWarning
        ? AppColors.errorColor.withOpacity(0.08)
        : Color(0xFFEEF2FF); // Indigo-50
    final valueColor =
        isWarning ? AppColors.errorColor : Color(0xFF1E1B4B); // Indigo-900
    final labelColor = Color(0xFF64748B); // Slate-500

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12), // Slightly larger padding
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ],
          ),
          child: Icon(
            icon,
            color: primaryColor,
            size: 22, // Slightly larger icon
          ),
        ),
        const SizedBox(height: 12), // More spacing
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.w600, // Semi-bold for better readability
          ),
        ),
        const SizedBox(height: 4), // Small gap between value and label
        Text(
          label,
          style: textTheme.bodySmall?.copyWith(
            color: labelColor,
            letterSpacing: 0.5, // Slightly spaced letters for modern look
          ),
        ),
      ],
    );
  }
}
