import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;
  final Duration duration;
  final double strokeWidth;
  final Border? border;

  const AnimatedText({
    super.key,
    required this.text,
    this.fontSize = 120,
    this.fontWeight = FontWeight.w900,
    this.color = Colors.black,
    this.letterSpacing = 1.2,
    this.duration = const Duration(seconds: 20),
    this.strokeWidth = 0.5,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.anton(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );

    final outlineStyle = GoogleFonts.anton(
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = color,
    );

    return Container(
      width: double.infinity,
      height: fontSize * 1.5,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            border ??
            const Border(
              top: BorderSide(color: Colors.black, width: 2),
              bottom: BorderSide(color: Colors.black, width: 2),
            ),
      ),
      child: OverflowBox(
        alignment: Alignment.centerLeft,
        minWidth: 0,
        maxWidth: double.infinity,
        child: RepaintBoundary(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$text  ', style: textStyle),
                TextSpan(text: '$text  ', style: outlineStyle),
                TextSpan(text: '$text  ', style: textStyle),
                TextSpan(text: '$text  ', style: outlineStyle),
              ],
            ),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .slideX(
          begin: 0.0,
          end: -0.5,
          duration: duration,
          curve: Curves.linear,
        ),
      ),
    );
  }
}
