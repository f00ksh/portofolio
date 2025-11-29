import 'package:flutter/material.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';

/// A widget that builds different layouts based on screen size breakpoints
///
/// Simplifies responsive design by providing separate builders for mobile,
/// tablet, and desktop layouts. Falls back to smaller breakpoints if larger
/// ones aren't provided.
///
/// Example:
/// ```dart
/// ResponsiveBuilder(
///   mobile: (context) => MobileLayout(),
///   tablet: (context) => TabletLayout(),
///   desktop: (context) => DesktopLayout(),
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  /// Builder for mobile layouts (< 768px)
  final Widget Function(BuildContext context) mobile;

  /// Optional builder for tablet layouts (768px - 1440px)
  /// Falls back to [mobile] if not provided
  final Widget Function(BuildContext context)? tablet;

  /// Optional builder for desktop layouts (>= 1440px)
  /// Falls back to [tablet] or [mobile] if not provided
  final Widget Function(BuildContext context)? desktop;

  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return (desktop ?? tablet ?? mobile)(context);
    } else if (Responsive.isTablet(context) ||
        Responsive.isTabletLarge(context)) {
      return (tablet ?? mobile)(context);
    }
    return mobile(context);
  }
}

/// A widget that provides responsive values based on screen size breakpoints
///
/// Useful for selecting different values (colors, sizes, etc.) based on
/// screen size without creating separate builder functions.
///
/// Example:
/// ```dart
/// ResponsiveValue<double>(
///   mobile: 16.0,
///   tablet: 24.0,
///   desktop: 32.0,
/// )
/// ```
class ResponsiveValue<T> extends StatelessWidget {
  /// Value for mobile layouts
  final T mobile;

  /// Optional value for tablet layouts
  /// Falls back to [mobile] if not provided
  final T? tablet;

  /// Optional value for desktop layouts
  /// Falls back to [tablet] or [mobile] if not provided
  final T? desktop;

  /// Builder function that receives the selected value
  final Widget Function(BuildContext context, T value) builder;

  const ResponsiveValue({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final T value;
    if (Responsive.isDesktop(context)) {
      value = desktop ?? tablet ?? mobile;
    } else if (Responsive.isTablet(context) ||
        Responsive.isTabletLarge(context)) {
      value = tablet ?? mobile;
    } else {
      value = mobile;
    }
    return builder(context, value);
  }
}
