import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_alumunium/common/theme/app_colors.dart';

class AppTheme {
  static bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  static bool isLightMode(BuildContext context) => !isDarkMode(context);

  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();

    // First build the text theme
    final TextTheme textTheme = _buildTextTheme(base.textTheme);

    // Then create a theme with the text theme applied
    final ThemeData themeWithTextTheme = base.copyWith(
      textTheme: textTheme,
      // colorScheme: ColorScheme.light(
      //   primary: AppColors.primaryColor,
      //   onPrimary: AppColors.bgColor,
      //   outline: AppColors.primaryDarkColor.withOpacity(0.1),
      //   surface: AppColors.bgColor,
      //   onSurface: AppColors.primaryDarkColor,
      // ),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.primaryWhiteColor,
      // unselectedWidgetColor: AppColors.unselectedColor,
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: AppColors.secondBgColor,
      //   surfaceTintColor: AppColors.secondBgColor,
      // ),
    );

    // Finally build the complete theme with all other components
    return _buildThemeComponents(themeWithTextTheme);
  }

  static ThemeData _buildThemeComponents(ThemeData base) {
    return base.copyWith(
      elevatedButtonTheme: _buildElevatedButtonTheme(base),
      filledButtonTheme: _buildFilledButtonTheme(base),
      iconTheme: _buildIconTheme(base),
      textButtonTheme: _buildTextButtonTheme(base),
      inputDecorationTheme: _buildInputDecorationTheme(base),
      appBarTheme: _buildAppBarTheme(base),
      bottomNavigationBarTheme: _bottomNavigationBarTheme(base),
      cardTheme: _buildCardTheme(base),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(ThemeData base) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: base.textTheme.titleMedium, padding: EdgeInsets.zero),
    );
  }

  static FilledButtonThemeData _buildFilledButtonTheme(ThemeData base) =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryWhiteColor,
          foregroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: base.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  static IconThemeData _buildIconTheme(ThemeData base) =>
      base.iconTheme.copyWith(color: base.colorScheme.primary);

  static ElevatedButtonThemeData _buildElevatedButtonTheme(ThemeData base) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        foregroundColor: base.colorScheme.onPrimary,
        textStyle: base.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: base.colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      ),
    );
  }

  static AppBarTheme _buildAppBarTheme(ThemeData base) {
    return AppBarTheme(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white, // Navigation bar
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static BottomNavigationBarThemeData _bottomNavigationBarTheme(
      ThemeData base) {
    return BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      selectedItemColor: AppColors.navBarSelectedItem,
      unselectedItemColor: AppColors.navBarUnselectedItem,
    );
  }

  static CardTheme _buildCardTheme(ThemeData base) {
    return CardTheme(
      color: AppColors.primaryWhiteColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 1.5,
          color: Colors.white,
        ),
      ),
      shadowColor: AppColors.primaryColor.withOpacity(0.1),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(ThemeData base) {
    // Create direct TextStyle objects for input decoration
    return InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryDarkColor,
        fontFamily: 'Roboto',
      ),
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.primaryDarkColor,
        fontFamily: 'Roboto',
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: AppColors.primaryDarkColor,
        fontFamily: 'hindSiliguri',
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryDarkColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme baseTheme) {
    const String fontFamily = 'Roboto';
    Color textColor = AppColors.primaryDarkColor;

    // Helper function to apply the common style to TextStyle
    TextStyle applyCommonStyle(
        TextStyle? style, double fontSize, FontWeight fontWeight) {
      return style?.copyWith(
            fontFamily: fontFamily,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ) ??
          TextStyle(
            fontFamily: fontFamily,
            color: textColor,
            fontSize: fontSize,
            fontWeight: fontWeight,
          );
    }

    return baseTheme.copyWith(
      displayLarge:
          applyCommonStyle(baseTheme.displayLarge, 32, FontWeight.w800),
      displayMedium:
          applyCommonStyle(baseTheme.displayMedium, 28, FontWeight.w800),
      displaySmall:
          applyCommonStyle(baseTheme.displaySmall, 24, FontWeight.w700),
      headlineLarge:
          applyCommonStyle(baseTheme.headlineLarge, 22, FontWeight.w700),
      headlineMedium:
          applyCommonStyle(baseTheme.headlineMedium, 20, FontWeight.w700),
      headlineSmall:
          applyCommonStyle(baseTheme.headlineSmall, 18, FontWeight.w700),
      titleLarge: applyCommonStyle(baseTheme.titleLarge, 16, FontWeight.w700),
      titleMedium: applyCommonStyle(baseTheme.titleMedium, 14, FontWeight.w600),
      titleSmall: applyCommonStyle(baseTheme.titleSmall, 12, FontWeight.w600),
      bodyLarge: applyCommonStyle(baseTheme.bodyLarge, 16, FontWeight.w400),
      bodyMedium: applyCommonStyle(baseTheme.bodyMedium, 14, FontWeight.w400),
      bodySmall: applyCommonStyle(baseTheme.bodySmall, 12, FontWeight.w400),
      labelLarge: applyCommonStyle(baseTheme.labelLarge, 14, FontWeight.w500),
      labelMedium: applyCommonStyle(baseTheme.labelMedium, 12, FontWeight.w500),
      labelSmall: applyCommonStyle(baseTheme.labelSmall, 10, FontWeight.w500),
    );
  }

  // Removed the .apply() call since we're already applying fontFamily and colors directly
}
