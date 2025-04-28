import 'package:flutter/material.dart';
import 'package:mobile_alumunium/styles/app_colors.dart';

class AppTheme {
  static bool isDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }

  static bool isLightMode(BuildContext context) => !isDarkMode(context);

  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: AppColors.bgColor,
        outline: AppColors.blackTextColor.withOpacity(0.1),
        surface: AppColors.bgColor,
        onSurface: AppColors.blackTextColor,
      ),
      // textTheme: GoogleFonts.urbanistTextTheme().apply(
      //   fontFamily: 'Urbanist',
      //   displayColor: AppColors.blackTextColor,
      //   bodyColor: AppColors.blackTextColor,
      // ),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.secondBgColor,
      unselectedWidgetColor: AppColors.unselectedColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.secondBgColor,
        surfaceTintColor: AppColors.secondBgColor,
      ),
    );
    return _buildTheme(base);
  }

  static ThemeData _buildTheme(ThemeData base) {
    return base.copyWith(
      // textTheme: _buildTextTheme(base),
      elevatedButtonTheme: _buildElevatedButtonTheme(base),
      filledButtonTheme: _buildFilledButtonTheme(base),
      iconTheme: _buildIconTheme(base),
      textButtonTheme: _textButtonTheme(base),
      floatingActionButtonTheme: _buildFloatingActionButtonTheme(),
    );
  }

  static TextButtonThemeData _textButtonTheme(ThemeData base) =>
      TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: base.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  static FloatingActionButtonThemeData _buildFloatingActionButtonTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
    );
  }

  static _buildFilledButtonTheme(ThemeData base) => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.whiteTextColor,
      foregroundColor: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        foregroundColor: AppColors.whiteTextColor,
        textStyle: base.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        backgroundColor: base.colorScheme.primary,
        disabledForegroundColor: AppColors.bgColor,
        disabledBackgroundColor: AppColors.unselectedColor.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      ),
    );
  }

  // static TextTheme _buildTextTheme(ThemeData base) {
  //   final textTheme = base.textTheme;
  //   return GoogleFonts.urbanistTextTheme(textTheme)
  //       .copyWith(
  //         headlineMedium: textTheme.headlineMedium?.copyWith(
  //           fontWeight: FontWeight.w800,
  //         ),
  //         headlineSmall: textTheme.headlineSmall?.copyWith(
  //           fontWeight: FontWeight.w700,
  //         ),
  //         titleLarge: textTheme.titleLarge?.copyWith(
  //           fontWeight: FontWeight.w700,
  //         ),
  //       )
  //       .apply(
  //         fontFamily: 'Urbanist',
  //         displayColor: AppColors.blackTextColor,
  //         bodyColor: AppColors.blackTextColor,
  //       );
  // }
}
