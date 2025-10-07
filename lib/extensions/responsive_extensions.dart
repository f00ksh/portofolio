import 'package:flutter/material.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';

extension ResponsiveDouble on double {
  double responsive(BuildContext context) {
    return this * Responsive.scaleFactor(context);
  }
}

extension ResponsiveInt on int {
  double responsive(BuildContext context) {
    return toDouble() * Responsive.scaleFactor(context);
  }
}
