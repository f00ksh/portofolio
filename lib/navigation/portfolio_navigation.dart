// portfolio_navigation.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/providers/scrolling_providers.dart';

class PortfolioSliverNavigation extends ConsumerWidget {
  const PortfolioSliverNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSection = ref.watch(currentSectionProvider);

    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      forceMaterialTransparency: true,
      floating: true,

      // snap: true,
      toolbarHeight: 100,
      expandedHeight: 0, // No expanded height to avoid taking space
      collapsedHeight: 100, // Height when collapsed
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(top: 30),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
              _buildNavItem('Home', 0, currentSection, ref),
              _buildNavItem('About', 1, currentSection, ref),
              _buildNavItem('Skills', 2, currentSection, ref),
              _buildNavItem('Award', 3, currentSection, ref),
              _buildNavItem('Projects', 4, currentSection, ref),
              _buildNavItem('Contact', 5, currentSection, ref),
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
        ),
      ),
    );
  }

  Widget _buildNavItem(
    String title,
    int index,
    int currentSection,
    WidgetRef ref,
  ) {
    final isActive = currentSection == index;
    final bgColor = isActive ? Colors.orange : Colors.transparent;

    return GestureDetector(
      onTap: () =>
          ref.read(scrollStateNotifierProvider.notifier).scrollToSection(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      ),
    );
  }
}
