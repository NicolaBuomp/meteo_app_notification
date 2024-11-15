import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      onPrimary: AppColors.white,
      secondary: AppColors.lightAccent,
      onSecondary: AppColors.white,
      surface: AppColors.lightCard,
      onSurface: AppColors.darkCard,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: AppTextStyles.headlineSmallLight,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLargeLight,
      headlineSmall: AppTextStyles.headlineSmallLight,
      bodyLarge: AppTextStyles.bodyLargeLight,
      bodyMedium: AppTextStyles.bodyMediumLight,
    ),
    cardTheme: CardTheme(
      color: AppColors.lightCard,
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.lightAccent),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.white),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.bodyLargeLight.copyWith(fontWeight: FontWeight.w500),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.lightPrimary),
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.bodyLargeLight,
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(AppColors.lightPrimary),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      onPrimary: AppColors.white,
      secondary: AppColors.darkAccent,
      onSecondary: AppColors.white,
      surface: AppColors.darkCard,
      onSurface: AppColors.darkText,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.white),
      titleTextStyle: AppTextStyles.headlineSmallDark,
    ),
    textTheme: TextTheme(
      headlineLarge: AppTextStyles.headlineLargeDark,
      headlineSmall: AppTextStyles.headlineSmallDark,
      bodyLarge: AppTextStyles.bodyLargeDark,
      bodyMedium: AppTextStyles.bodyMediumDark,
    ),
    cardTheme: CardTheme(
      color: AppColors.darkCard,
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(AppColors.darkAccent),
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.darkText),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.bodyLargeDark.copyWith(fontWeight: FontWeight.w500),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(AppColors.darkAccent),
        textStyle: WidgetStateProperty.all<TextStyle>(
          AppTextStyles.bodyLargeDark,
        ),
      ),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all<Color>(AppColors.darkAccent),
    ),
  );
}
