import 'package:flutter/material.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';

import 'app_colors.dart';

/// Responsive text styles - replaces hardcoded values with fluid typography
class AppTextStyles {
  /// Hero title - main name on landing page
  /// Mobile: 48-64px, Tablet: 72-96px, Desktop: 120px
  static TextStyle heroTitle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 56,
        tablet: 84,
        desktop: 120,
      ),
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
      height: 1.2,
    );
  }

  /// Hero subtitle - job title
  /// Mobile: 18-24px, Tablet: 28-32px, Desktop: 36px
  static TextStyle heroSubtitle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 20,
        tablet: 28,
        desktop: 36,
      ),
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w500,
      height: 1.4,
    );
  }

  /// Section title - "EXPERIENCE", "SKILLS", etc.
  /// Mobile: 36-48px, Tablet: 64-80px, Desktop: 96-120px
  static TextStyle sectionTitle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 40,
        tablet: 72,
        desktop: 100,
      ),
      fontWeight: FontWeight.w900,
      color: AppColors.textPrimary,
      height: 1.2,
      letterSpacing: 1.2,
    );
  }

  /// Body text - paragraphs and descriptions
  /// Mobile: 14-16px, Tablet: 16-18px, Desktop: 18px
  static TextStyle bodyText(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 14,
        tablet: 16,
        desktop: 18,
      ),
      height: 1.6,
      color: AppColors.textPrimary,
    );
  }

  /// Body text bold variant
  static TextStyle bodyTextBold(BuildContext context) {
    return bodyText(context).copyWith(
      fontWeight: FontWeight.bold,
      fontSize: ResponsiveSize.text(
        context,
        mobile: 15,
        tablet: 17,
        desktop: 19,
      ),
    );
  }

  /// Card title
  /// Mobile: 16-18px, Tablet: 18-20px, Desktop: 20-22px
  static TextStyle cardTitle(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 16,
        tablet: 18,
        desktop: 20,
      ),
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
      height: 1.3,
    );
  }

  /// Navigation item text
  /// Mobile: 14px, Tablet: 16px, Desktop: 18px
  static TextStyle navItem(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 14,
        tablet: 16,
        desktop: 18,
      ),
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
    );
  }

  /// Small text - captions, labels
  /// Mobile: 12px, Tablet: 13px, Desktop: 14px
  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 12,
        tablet: 13,
        desktop: 14,
      ),
      color: AppColors.textPrimary.withOpacity(0.7),
      height: 1.4,
    );
  }

  /// Button text
  /// Mobile: 14px, Tablet: 15px, Desktop: 16px
  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontSize: ResponsiveSize.text(
        context,
        mobile: 14,
        tablet: 15,
        desktop: 16,
      ),
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      letterSpacing: 0.5,
    );
  }
}
