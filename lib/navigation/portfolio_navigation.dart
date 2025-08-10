import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/providers/scrolling_providers.dart';

class PortfolioNavigation extends ConsumerWidget {
  const PortfolioNavigation({super.key, required this.scrollParams});

  final ({int sectionCount, double screenHeight}) scrollParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the new providers with parameters
    final currentSection = ref.watch(
      scrollControllerNotifierProvider(
        scrollParams,
      ).select((s) => s.currentSection),
    );
    final isVisible = ref.watch(
      scrollControllerNotifierProvider(
        scrollParams,
      ).select((s) => s.isNavigationVisible),
    );

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child:
              Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNavItem('Home', 0, currentSection, ref, context),
                        _buildNavItem('About', 1, currentSection, ref, context),
                        _buildNavItem(
                          'Skills',
                          2,
                          currentSection,
                          ref,
                          context,
                        ),
                        _buildNavItem('Award', 3, currentSection, ref, context),
                        _buildNavItem(
                          'Projects',
                          4,
                          currentSection,
                          ref,
                          context,
                        ),
                        _buildNavItem(
                          'Contact',
                          5,
                          currentSection,
                          ref,
                          context,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Portfolio 🔒',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .animate(target: isVisible ? 1 : 0)
                  .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
                  .slideY(
                    begin: -0.5,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  )
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 350.ms,
                    curve: Curves.easeOutCubic,
                  ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String title,
    int index,
    int currentSection,
    WidgetRef ref,
    BuildContext context,
  ) {
    final isActive = currentSection == index;
    final bgColor = isActive ? Colors.orange : Colors.transparent;

    return GestureDetector(
      onTap: () {
        // Use the new scroll controller notifier
        ref
            .read(scrollControllerNotifierProvider(scrollParams).notifier)
            .scrollToSection(index, context);
      },
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              )
              .animate(target: isActive ? 1 : 0)
              .scale(
                begin: const Offset(1.0, 1.0),
                end: const Offset(1.05, 1.05),
                duration: 200.ms,
                curve: Curves.easeOutCubic,
              ),
    );
  }
}
