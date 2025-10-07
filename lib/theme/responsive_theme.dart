import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';

class ResponsiveTheme {
  /// Get responsive text theme for MaterialApp
  static TextTheme getResponsiveTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 48, tablet: 56, desktop: 64),
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 40, tablet: 48, desktop: 56),
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 32, tablet: 40, desktop: 48),
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 28, tablet: 32, desktop: 36),
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 24, tablet: 28, desktop: 32),
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 16, tablet: 17, desktop: 18),
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 14, tablet: 15, desktop: 16),
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: ResponsiveSize.text(context, mobile: 12, tablet: 13, desktop: 14),
      ),
    );
  }

  /// Get responsive padding with standard values
  static EdgeInsets getResponsivePadding(BuildContext context, {
    double scale = 1.0,
  }) {
    final base = Responsive.valueWhen(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
    return EdgeInsets.all(base * scale);
  }

  /// Get responsive horizontal padding
  static EdgeInsets getResponsiveHorizontalPadding(BuildContext context, {
    double scale = 1.0,
  }) {
    final base = Responsive.valueWhen(
      context,
      mobile: 16.0,
      tablet: 32.0,
      desktop: 48.0,
    );
    return EdgeInsets.symmetric(horizontal: base * scale);
  }

  /// Get responsive vertical padding
  static EdgeInsets getResponsiveVerticalPadding(BuildContext context, {
    double scale = 1.0,
  }) {
    final base = Responsive.valueWhen(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );
    return EdgeInsets.symmetric(vertical: base * scale);
  }

  /// Get responsive margin
  static EdgeInsets getResponsiveMargin(BuildContext context, {
    double scale = 1.0,
  }) {
    return getResponsivePadding(context, scale: scale);
  }

  /// Get responsive border radius
  static BorderRadius getResponsiveBorderRadius(BuildContext context, {
    double scale = 1.0,
  }) {
    final base = Responsive.valueWhen(
      context,
      mobile: 8.0,
      tablet: 12.0,
      desktop: 16.0,
    );
    return BorderRadius.circular(base * scale);
  }

  /// Get responsive content max width
  static double getContentMaxWidth(BuildContext context) {
    return Responsive.valueWhen(
      context,
      mobile: double.infinity,
      tablet: 900.0,
      desktop: 1200.0,
    );
  }

  /// Get responsive section spacing
  static double getSectionSpacing(BuildContext context) {
    return Responsive.valueWhen(
      context,
      mobile: 40.0,
      tablet: 60.0,
      desktop: 80.0,
    );
  }
}
