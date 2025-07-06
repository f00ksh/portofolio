import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

class HeroSectionCard extends ConsumerStatefulWidget {
  const HeroSectionCard({super.key});

  @override
  ConsumerState<HeroSectionCard> createState() => _HeroSectionCardState();
}

class _HeroSectionCardState extends ConsumerState<HeroSectionCard>
    with SingleTickerProviderStateMixin {
  // Single animation controller for all animations
  late AnimationController _controller;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  // Rive controller
  RiveAnimationController? _riveController;

  @override
  void initState() {
    super.initState();

    // Initialize single controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Setup animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Start animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _riveController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      decoration: BoxDecoration(color: const Color(0xFFd661ff)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          // Rive Animation
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _fadeAnimation.value,
                  child: SizedBox(
                    width: size.width * 0.8,
                    height: size.height * 0.3,
                    child: Lottie.asset(
                      'assets/animations/ciao.json',
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      frameRate: FrameRate.max,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          Column(
            children: [
              Text(
                'i\'m Mohamed\n      Fouda',
                style: GoogleFonts.anton(
                  fontSize: 120,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.4,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 20),

              // Text Content
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Opacity(
                      opacity: _fadeAnimation.value,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          border: Border.all(color: Colors.black, width: 3),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 4),
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                        child: Text(
                          'Software Engineer',
                          style: GoogleFonts.anton(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.4,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
