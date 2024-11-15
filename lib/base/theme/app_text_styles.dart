// lib/base/theme/app_text_styles.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Stili per il tema chiaro
  static const TextStyle headlineLargeLight = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.lightText,
  );

  static const TextStyle headlineSmallLight = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.lightText,
  );

  static const TextStyle bodyLargeLight = TextStyle(
    fontSize: 16,
    color: AppColors.lightText,
  );

  static const TextStyle bodyMediumLight = TextStyle(
    fontSize: 14,
    color: AppColors.lightText,
  );

  // Stili per il tema scuro
  static const TextStyle headlineLargeDark = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.darkText,
  );

  static const TextStyle headlineSmallDark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.darkText,
  );

  static const TextStyle bodyLargeDark = TextStyle(
    fontSize: 16,
    color: AppColors.darkText,
  );

  static const TextStyle bodyMediumDark = TextStyle(
    fontSize: 14,
    color: AppColors.darkText,
  );
}
