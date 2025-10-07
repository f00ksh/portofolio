import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_web/screens/award/workmarquee.dart';

class CertificationsSectionCard extends StatelessWidget {
  const CertificationsSectionCard({super.key});

  static const _certificationsData = [
    {
      'title': 'Bachelor Degree in Engineering',
      'issuer': 'University',
      'year': '2020',
    },
    {
      'title': 'Cross Platform Development with Flutter & Dart',
      'issuer': 'Udemy',
      'year': '2023',
    },
    {
      'title': 'Android Development with Kotlin and Jetpack',
      'issuer': 'Udemy',
      'year': '2024',
    },
    // animattion with lottie and rive
    {
      'title': 'Animation with Lottie and Rive',
      'issuer': 'Online Course',
      'year': '2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Lottie animation background
              Positioned.fill(
                child: Container(
                  color: const Color(0xFFd661ff),
                  child: Lottie.asset(
                    'assets/animations/award.json',
                    fit: BoxFit.cover,
                    repeat: true,
                    frameRate: FrameRate.max,
                  ),
                ),
              ),

              // Content overlay
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20.0 : 60.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: isMobile ? 40 : 60),
                    _Header(isMobile: isMobile),
                    SizedBox(height: isMobile ? 16 : 24),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _certificationsData.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: isMobile ? 16 : 24),
                        itemBuilder: (context, index) {
                          final certification = _certificationsData[index];
                          return CertificationCard(
                            title: certification['title']!,
                            issuer: certification['issuer']!,
                            year: certification['year']!,
                            isMobile: isMobile,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                  ],
                ),
              ),
            ],
          ),
        ),
        const WorkMarquee(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final bool isMobile;
  const _Header({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Certifications',
        textAlign: TextAlign.center,
        style: GoogleFonts.anton(
          fontSize: isMobile ? 36 : 80,
          letterSpacing: isMobile ? 2 : 4,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          shadows: [
            Shadow(
              offset: const Offset(2, 2),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class CertificationCard extends StatelessWidget {
  final String title;
  final String issuer;
  final String year;
  final bool isMobile;

  const CertificationCard({
    super.key,
    required this.title,
    required this.issuer,
    required this.year,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return _buildMobileCard();
    }
    return _buildDesktopCard();
  }

  Widget _buildMobileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Year badge
              Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFd661ff),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  year,
                  style: GoogleFonts.anton(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 72),
            child: Text(
              issuer,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Year badge
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFd661ff),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text(
              year,
              style: GoogleFonts.anton(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              issuer,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
