import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static Color primaryColor = const Color(0xFF4942E4);
  static Color primaryWhiteColor = const Color(0xFFFFFFFF);
  static Color primaryDarkColor = const Color(0xFF030303);
  static Color errorColor = const Color(0xFFE74C3C);
  static Color successColor = const Color(0xFF2ECC71);
  static Color warningColor = const Color(0xFFF39C12);

  // Grey Scale
  static Color primaryGreyColor = const Color(0xFF9E9E9E);

  // Modern Design Colors
  static Color lightPrimaryColor = const Color(0xFF6A63FE);
  static Color scaffoldBackground = const Color(0xFFF8F9FA);
  static Color navBarBackground = const Color(0xFFFFFFFF);
  static Color navBarSelectedItem = const Color(0xFF4942E4);
  static Color navBarUnselectedItem = const Color(0xFF8E8E93);
  static Color navBarIndicator = const Color(0xFF4942E4);
  static Color cardBackground = const Color(0xFFFFFFFF);

  // Text Colors
  static Color textPrimary = const Color(0xFF212121);
  static Color textSecondary = const Color(0xFF757575);
  static Color textDisabled = const Color(0xFF9E9E9E);

  // Status Colors
  static Color infoColor = const Color(0xFF3498DB);
  static Color highlightColor = const Color(0xFFFFF9C4);

  // Gradients
  static List<Color> secondaryGradientColor = [
    const Color(0xFF6A63FE).withOpacity(0.7),
    const Color(0xFFA5B4FC),
    const Color(0xFFE0E7FF),
  ];

  static List<Color> primaryGradientColor = [
    primaryColor,
    lightPrimaryColor,
    const Color(0xFF8E2DE2), // Added for better gradient transition
  ];

  // Card Shadows
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    offset: const Offset(0, 4),
  );
}
