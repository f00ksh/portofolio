/// Centralized dimension constants for consistent spacing and sizing
class AppDimensions {
  AppDimensions._();

  // Navigation heights
  static const double navigationHeightMobile = 70.0;
  static const double navigationHeightDesktop = 100.0;

  // Scroll & Layout
  static const double maxCardOverlap = 500.0;

  // Border widths
  static const double borderWidthStandard = 2.0;
  static const double borderWidthThick = 3.0;

  // Border radius values
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 20.0;
  static const double borderRadiusRound = 50.0;

  // Standard spacing values (4px grid system)
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing60 = 60.0;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationStandard = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 600);
  static const Duration animationExtraSlow = Duration(milliseconds: 800);

  // Shadow offsets
  static const double shadowOffsetSmall = 2.0;
  static const double shadowOffsetMedium = 4.0;
  static const double shadowOffsetLarge = 6.0;
}
