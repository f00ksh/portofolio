import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'responsive_utils.dart';

/// Responsive sizing utilities for text, spacing, and dimensions
/// Uses fluid scaling and breakpoint-specific values
class ResponsiveSize {
  // Base spacing unit (4px grid system)
  static const double _baseUnit = 4.0;

  /// Responsive text sizing using fluid typography
  /// Scales smoothly between breakpoints
  /// Now considers BOTH width and height for better scaling on all screens
  static double text(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
    bool scaleWithHeight = true,
  }) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    double baseSize;

    // Mobile range (< 768)
    if (width < Responsive.tablet) {
      baseSize = _fluidScale(
        width: width,
        minWidth: Responsive.mobileSmall,
        maxWidth: Responsive.tablet,
        minSize: mobile,
        maxSize: tablet ?? mobile,
      );
    }
    // Tablet range (768 - 1440)
    else if (width < Responsive.desktop) {
      final tabletSize = tablet ?? mobile * 1.2;
      baseSize = _fluidScale(
        width: width,
        minWidth: Responsive.tablet,
        maxWidth: Responsive.desktop,
        minSize: tabletSize,
        maxSize: desktop ?? tabletSize,
      );
    }
    // Desktop range (>= 1440)
    else {
      baseSize = desktop ?? tablet ?? mobile * 1.4;
    }

    // Apply height scaling factor for small screens
    if (scaleWithHeight && height < 900) {
      // Scale down for short screens (common on laptops: 768px, 800px, 900px)
      final heightFactor = (height / 900).clamp(0.7, 1.0);
      baseSize *= heightFactor;
    }

    return baseSize;
  }

  /// Responsive spacing using 4px grid system
  /// Returns spacing in multiples of 4
  /// Now considers screen height for better scaling
  static double space(BuildContext context, double multiplier) {
    final baseSpace = _baseUnit * multiplier;
    final height = Responsive.height(context);

    double widthMultiplier;
    if (Responsive.isMobile(context)) {
      widthMultiplier = 1.0;
    } else if (Responsive.isTablet(context) ||
        Responsive.isTabletLarge(context)) {
      widthMultiplier = 1.1;
    } else {
      widthMultiplier = 1.2;
    }

    // Scale down spacing on short screens
    double heightMultiplier = 1.0;
    if (height < 900) {
      heightMultiplier = (height / 900).clamp(0.75, 1.0);
    }

    return baseSpace * widthMultiplier * heightMultiplier;
  }

  /// Responsive width with max constraints
  static double width(
    BuildContext context, {
    double mobileFactor = 1.0,
    double? tabletFactor,
    double? desktopFactor,
    double? maxWidth,
  }) {
    final screenWidth = Responsive.width(context);
    double factor;

    if (Responsive.isDesktop(context)) {
      factor = desktopFactor ?? tabletFactor ?? mobileFactor;
    } else if (Responsive.isTablet(context) ||
        Responsive.isTabletLarge(context)) {
      factor = tabletFactor ?? mobileFactor;
    } else {
      factor = mobileFactor;
    }

    final calculatedWidth = screenWidth * factor;
    return maxWidth != null
        ? math.min(calculatedWidth, maxWidth)
        : calculatedWidth;
  }

  /// Responsive height
  static double height(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return Responsive.valueWhen(
      context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Responsive padding using EdgeInsets
  static EdgeInsets padding(
    BuildContext context, {
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    final multiplier = _getSpacingMultiplier(context);

    if (all != null) {
      return EdgeInsets.all(all * multiplier);
    }

    return EdgeInsets.only(
      left: (left ?? horizontal ?? 0) * multiplier,
      top: (top ?? vertical ?? 0) * multiplier,
      right: (right ?? horizontal ?? 0) * multiplier,
      bottom: (bottom ?? vertical ?? 0) * multiplier,
    );
  }

  /// Responsive margin
  static EdgeInsets margin(
    BuildContext context, {
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return padding(
      context,
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  /// Responsive border radius
  static BorderRadius borderRadius(BuildContext context, double baseRadius) {
    final multiplier = _getSpacingMultiplier(context);
    return BorderRadius.circular(baseRadius * multiplier);
  }

  /// Icon size
  static double iconSize(
    BuildContext context, {
    double mobile = 24,
    double? tablet,
    double? desktop,
  }) {
    return Responsive.valueWhen(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.4,
    );
  }

  /// Size that scales with BOTH width and height (viewport-relative)
  /// Perfect for elements that need to fit within viewport
  static double vhSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final width = Responsive.width(context);
    final height = Responsive.height(context);

    double baseSize;
    if (width < Responsive.tablet) {
      baseSize = mobile;
    } else if (width < Responsive.desktop) {
      baseSize = tablet ?? mobile * 1.2;
    } else {
      baseSize = desktop ?? mobile * 1.4;
    }

    // Apply height constraint - scale down if height is limited
    final heightFactor = (height / 1080).clamp(0.6, 1.0);
    return baseSize * heightFactor;
  }

  /// Get percentage of viewport height
  static double vh(BuildContext context, double percentage) {
    return Responsive.height(context) * (percentage / 100);
  }

  /// Get percentage of viewport width
  static double vw(BuildContext context, double percentage) {
    return Responsive.width(context) * (percentage / 100);
  }

  // Private helper methods

  /// Fluid scaling formula for smooth size transitions
  static double _fluidScale({
    required double width,
    required double minWidth,
    required double maxWidth,
    required double minSize,
    required double maxSize,
  }) {
    if (width <= minWidth) return minSize;
    if (width >= maxWidth) return maxSize;

    // Linear interpolation
    final ratio = (width - minWidth) / (maxWidth - minWidth);
    return minSize + (maxSize - minSize) * ratio;
  }

  /// Get spacing multiplier based on screen size
  static double _getSpacingMultiplier(BuildContext context) {
    if (Responsive.isMobile(context)) {
      return 1.0;
    } else if (Responsive.isTablet(context) ||
        Responsive.isTabletLarge(context)) {
      return 1.1;
    }
    return 1.2;
  }
}

/// Extension for convenient responsive sizing on numbers
extension ResponsiveSizeExtension on num {
  /// Convert to responsive space
  double toSpace(BuildContext context) {
    return ResponsiveSize.space(context, toDouble());
  }

  /// Convert to responsive text size
  double toResponsiveText(
    BuildContext context, {
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveSize.text(
      context,
      mobile: toDouble(),
      tablet: tablet,
      desktop: desktop,
    );
  }
}
