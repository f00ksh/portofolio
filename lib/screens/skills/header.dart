import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameHeader extends StatelessWidget {
  const GameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeaderText();
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Technology & Skills",
      style: GoogleFonts.anton(
        height: 1.5,
        fontSize: 120,
        fontWeight: FontWeight.w900,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = .5
          ..color = const Color(0xFF000000),
      ),
    );
  }
}
