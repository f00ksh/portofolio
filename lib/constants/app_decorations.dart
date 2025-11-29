import 'package:flutter/material.dart';

/// Centralized decoration styles for consistent neobrutalist design
class AppDecorations {
  AppDecorations._();

  // Border styles
  static Border neobrutalistBorder({
    Color color = Colors.black,
    double width = 2.0,
  }) {
    return Border.all(color: color, width: width);
  }

  // Shadow styles
  static List<BoxShadow> neobrutalistShadow({
    Color color = Colors.black,
    Offset offset = const Offset(4, 4),
    double blurRadius = 0,
  }) {
    return [
      BoxShadow(
        color: color,
        offset: offset,
        blurRadius: blurRadius,
      ),
    ];
  }

  // Standard border radius values
  static BorderRadius borderRadius({
    double radius = 16,
  }) {
    return BorderRadius.circular(radius);
  }

  // Predefined border radius sizes
  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(12));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(16));
  static const BorderRadius borderRadiusXLarge = BorderRadius.all(Radius.circular(20));
  static const BorderRadius borderRadiusRound = BorderRadius.all(Radius.circular(50));

  // Combined neobrutalist card decoration
  static BoxDecoration neobrutalistCard({
    Color color = Colors.white,
    double borderRadius = 16,
    double borderWidth = 2,
    Color borderColor = Colors.black,
    Offset shadowOffset = const Offset(4, 4),
    double shadowBlur = 0,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: shadowOffset,
          blurRadius: shadowBlur,
        ),
      ],
    );
  }

  // Larger shadow variant
  static List<BoxShadow> neobrutalistShadowLarge({
    Color color = Colors.black,
    Offset offset = const Offset(6, 6),
  }) {
    return [
      BoxShadow(
        color: color,
        offset: offset,
        blurRadius: 0,
      ),
    ];
  }

  // Button decoration
  static BoxDecoration neobrutalistButton({
    required Color color,
    double borderRadius = 16,
    double borderWidth = 2,
    Color borderColor = Colors.black,
    Offset shadowOffset = const Offset(2, 2),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: borderWidth),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          offset: shadowOffset,
          blurRadius: 0,
        ),
      ],
    );
  }

  // Input field decoration
  static BoxDecoration neobrutalistInput({
    Color color = Colors.white,
    double borderRadius = 16,
    double borderWidth = 2,
    Color borderColor = Colors.black,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor, width: borderWidth),
    );
  }
}
