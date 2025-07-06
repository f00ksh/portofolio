import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heroTitle = TextStyle(
    fontSize: 150,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
    height: 2,
  );

  static const TextStyle heroSubtitle = TextStyle(
    fontSize: 48,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText = TextStyle(fontSize: 18, height: 1.6);

  static const TextStyle cardTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle navItem = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
}
