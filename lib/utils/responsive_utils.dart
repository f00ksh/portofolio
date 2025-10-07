import 'package:flutter/material.dart';

class Responsive {
  // Enhanced breakpoints - Material Design 3 aligned
  static const double mobileSmall = 320;
  static const double mobileMedium = 375;
  static const double mobileLarge = 428;
  static const double tablet = 768;
  static const double tabletLarge = 1024;
  static const double desktop = 1440;
  static const double desktopLarge = 1920;

  // Legacy breakpoints for backward compatibility
  static const double mobileBreakpoint = tablet;
  static const double tabletBreakpoint = tabletLarge;

  // Device type checks
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < tablet;

  static bool isMobileSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMedium;

  static bool isMobileMedium(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileMedium &&
      MediaQuery.of(context).size.width < mobileLarge;

  static bool isMobileLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileLarge &&
      MediaQuery.of(context).size.width < tablet;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= tablet &&
      MediaQuery.of(context).size.width < tabletLarge;

  static bool isTabletLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletLarge &&
      MediaQuery.of(context).size.width < desktop;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktop;

  static bool isDesktopLarge(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopLarge;

  // Size helpers
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Get current breakpoint category
  static String getBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMedium) return 'mobile-small';
    if (width < mobileLarge) return 'mobile-medium';
    if (width < tablet) return 'mobile-large';
    if (width < tabletLarge) return 'tablet';
    if (width < desktop) return 'tablet-large';
    if (width < desktopLarge) return 'desktop';
    return 'desktop-large';
  }

  // Value selector based on breakpoint
  static T valueWhen<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context) || isTabletLarge(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  // @deprecated - Use responsive sizing utilities instead
  @Deprecated('Use ResponsiveSize utilities instead')
  static double scaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < tablet) return 1.0;
    if (width < tabletLarge) return 1.1;
    if (width < desktop) return 1.2;
    return 1.3;
  }
}
