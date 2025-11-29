import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_web/constants/app_text_styles.dart';
import 'package:portfolio_web/utils/responsive_sizing.dart';
import 'package:portfolio_web/utils/responsive_utils.dart';

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
    final isMobile = Responsive.isMobile(context);

    // Calculate available height (accounting for navigation)
    final navHeight = isMobile ? 70.0 : 100.0;
    // final availableHeight = size.height - navHeight;
    return Container(
      height: size.height,
      decoration: const BoxDecoration(color: Color(0xFFd661ff)),
      child: Stack(
        children: [
          // Main content centered with proper spacing
          Positioned.fill(
            top: navHeight, // Start below navigation
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: ResponsiveSize.padding(context, horizontal: 4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Lottie animation - height-aware sizing
                      SizedBox(
                            child: Lottie.asset(
                              'assets/animations/Hello.json',
                              fit: BoxFit.contain,
                              frameRate: FrameRate.max,
                              controller: _lottieController,
                              onLoaded: (composition) {
                                _lottieController.duration = Duration(
                                  milliseconds:
                                      (composition.duration.inMilliseconds /
                                              1.5)
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

                      SizedBox(height: ResponsiveSize.space(context, 3)),

                      // Name text - height-aware sizing
                      Text(
                            "I'm Mohamed\nFouda",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.heroTitle(
                              context,
                            ).copyWith(fontFamily: 'Satoshi'),
                          )
                          .animate(delay: 1000.ms)
                          .fadeIn(
                            begin: 0.0,
                            duration: 800.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 30,
                            end: 0,
                            duration: 800.ms,
                            curve: Curves.easeOut,
                          ),

                      SizedBox(height: ResponsiveSize.space(context, 2)),

                      // Job title
                      Text(
                            "Android & Flutter Developer",
                            textAlign: TextAlign.start,
                            style: AppTextStyles.heroSubtitle(
                              context,
                            ).copyWith(fontFamily: 'Satoshi'),
                          )
                          .animate(delay: 2000.ms)
                          .fadeIn(
                            begin: 0.0,
                            duration: 700.ms,
                            curve: Curves.easeOut,
                          )
                          .slideY(
                            begin: 30,
                            end: 0,
                            duration: 700.ms,
                            curve: Curves.easeOut,
                          ),

                      SizedBox(height: ResponsiveSize.vh(context, 5)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Scroll indicator - responsive positioning
          Positioned(
            bottom: ResponsiveSize.vh(context, 5),
            right: ResponsiveSize.vw(context, 5),
            child:
                SizedBox(
                      height: ResponsiveSize.vhSize(
                        context,
                        mobile: 60,
                        tablet: 80,
                        desktop: 100,
                      ),
                      child: Lottie.asset(
                        'assets/animations/scroll_down.json',
                        frameRate: FrameRate.max,
                        repeat: true,
                      ),
                    )
                    .animate(delay: 2500.ms)
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
