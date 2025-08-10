import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class HeroSectionCard extends ConsumerStatefulWidget {
  const HeroSectionCard({super.key});

  @override
  ConsumerState<HeroSectionCard> createState() => _HeroSectionCardState();
}

class _HeroSectionCardState extends ConsumerState<HeroSectionCard>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Container(
      height: size.height,
      decoration: const BoxDecoration(color: Color(0xFFd661ff)),
      child: Stack(
        children: [
          // Main content centered
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Lottie animation - appears first
                SizedBox(
                      child: Lottie.asset(
                        'assets/animations/Hello.json',
                        fit: BoxFit.contain,
                        width: size.width * 0.74,

                        frameRate: FrameRate.max,
                        controller: _lottieController,
                        onLoaded: (composition) {
                          _lottieController.duration = Duration(
                            milliseconds:
                                (composition.duration.inMilliseconds / 1.5)
                                    .round(),
                          );
                          _lottieController.repeat();
                        },
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 1000.ms,
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: 20),

                // Name text
                Text(
                      "I'm Mohamed\nFouda",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 48 : 120,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    )
                    .animate(delay: 1000.ms)
                    .fadeIn(begin: 0.0, duration: 800.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: 30,
                      end: 0,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    ),

                SizedBox(height: isSmallScreen ? 20 : 30),

                // Job title - appears third (after name)
                Text(
                      "Android & Flutter Developer",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 20 : 36,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.normal,
                      ),
                    )
                    .animate(delay: 2000.ms) // Further increased delay
                    .fadeIn(begin: 0.0, duration: 700.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: 30,
                      end: 0,
                      duration: 700.ms,
                      curve: Curves.easeOut,
                    ),
              ],
            ),
          ),

          // Scroll indicator - appears last (bottom right)
          Positioned(
            bottom: 50,
            right: 50,
            child:
                SizedBox(
                      height: isSmallScreen
                          ? size.height * 0.1
                          : size.height * 0.15,
                      child: Lottie.asset(
                        'assets/animations/scroll_down.json',
                        frameRate: FrameRate.max,
                        repeat: true,
                      ),
                    )
                    .animate(delay: 2500.ms) // Last to appear
                    .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: 30,
                      end: 0,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    )
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1.0, 1.0),
                      duration: 800.ms,
                      curve: Curves.elasticOut,
                    ),
          ),
        ],
      ),
    );
  }
}
