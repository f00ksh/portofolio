import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/navigation/portfolio_navigation.dart';
import 'package:portfolio_web/providers/scrolling_providers.dart';
import 'package:portfolio_web/screens/about/about_section_card.dart';
import 'package:portfolio_web/screens/award/award_section.dart';
import 'package:portfolio_web/screens/contact/contact_section_card.dart';
import 'package:portfolio_web/screens/home/hero_section_card.dart';
import 'package:portfolio_web/screens/projects/projects_section_card.dart';
import 'package:portfolio_web/screens/skills/skills.dart';

class PortfolioHomePage extends ConsumerWidget {
  const PortfolioHomePage({super.key});

  static const List<Widget> _sections = [
    HeroSectionCard(),
    ExperienceScreen(),
    GameRectangle(), // Skills section
    CertificationsSectionCard(),
    ProjectsSectionCard(),
    ContactSectionCard(),
  ];

  static const double _maxOverlap = 500.0;
  static const Color _backgroundColor = Color(0xFFd661ff);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final scrollParams = (
      sectionCount: _sections.length,
      screenHeight: screenHeight,
    );

    final scrollController = ref
        .watch(scrollControllerNotifierProvider(scrollParams).notifier)
        .controller;
    final totalHeight =
        (_sections.length - 1) * screenHeight * 0.8 + screenHeight;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: totalHeight,
                  child: _StackedCardsView(
                    sections: _sections,
                    maxOverlap: _maxOverlap,
                    scrollParams: scrollParams,
                  ),
                ),
              ),
            ],
          ),
          // Your existing navigation with scroll params
          PortfolioNavigation(scrollParams: scrollParams),
        ],
      ),
    );
  }
}

class _StackedCardsView extends ConsumerWidget {
  const _StackedCardsView({
    required this.sections,
    required this.maxOverlap,
    required this.scrollParams,
  });

  final List<Widget> sections;
  final double maxOverlap;
  final ({int sectionCount, double screenHeight}) scrollParams;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollState = ref.watch(
      scrollControllerNotifierProvider(scrollParams),
    );

    return RepaintBoundary(
      child: _StackedCards(
        sections: sections,
        maxOverlap: maxOverlap,
        screenHeight: scrollParams.screenHeight,
        scrollOffset: scrollState.offset,
        currentSection: scrollState.currentSection,
        sectionProgress: scrollState.sectionProgress,
      ),
    );
  }
}

class _StackedCards extends StatelessWidget {
  const _StackedCards({
    required this.sections,
    required this.maxOverlap,
    required this.screenHeight,
    required this.scrollOffset,
    required this.currentSection,
    required this.sectionProgress,
  });

  final List<Widget> sections;
  final double maxOverlap;
  final double screenHeight;
  final double scrollOffset;
  final int currentSection;
  final double sectionProgress;

  @override
  Widget build(BuildContext context) {
    final sectionCount = sections.length;
    final spacingFactor = _calculateSpacingFactor(
      scrollOffset,
      screenHeight,
      sectionCount,
    );
    final baseStride = screenHeight * spacingFactor;
    final halfStep = screenHeight * 0.5;

    return Stack(
      children: [
        for (int i = 0; i < sectionCount; i++)
          _StackedCard(
            section: sections[sectionCount - 1 - i], // Reverse order
            screenHeight: screenHeight,
            cardOffset: _calculateCardOffset(
              sectionCount - 1 - i,
              scrollOffset,
              baseStride,
              halfStep,
              maxOverlap,
            ),
            translateY: _calculateTranslateY(
              scrollOffset,
              _calculateCardOffset(
                sectionCount - 1 - i,
                scrollOffset,
                baseStride,
                halfStep,
                maxOverlap,
              ),
              halfStep,
            ),
            isCurrentSection: (sectionCount - 1 - i) == currentSection,
            sectionProgress: (sectionCount - 1 - i) == currentSection
                ? sectionProgress
                : 0.0,
          ),
      ],
    );
  }

  // Your existing calculation methods remain the same...
  double _calculateSpacingFactor(
    double scrollOffset,
    double screenHeight,
    int sectionCount,
  ) {
    if (scrollOffset <= 0) return 1.0;
    final factor = 0.8 + (scrollOffset / (screenHeight * sectionCount)) * 0.58;
    return factor.clamp(0.0, 0.8);
  }

  double _calculateCardOffset(
    int revIndex,
    double scrollOffset,
    double baseStride,
    double halfStep,
    double maxOverlap,
  ) {
    double cardOffset = 0.0;
    for (int j = 0; j < revIndex; j++) {
      final cardScrollOffset = scrollOffset - (j * baseStride);
      final overlapProgress = (cardScrollOffset / halfStep).clamp(0.0, 1.0);
      final currentOverlap = maxOverlap * (1.0 - overlapProgress);
      cardOffset += baseStride - currentOverlap;
    }
    return cardOffset;
  }

  double _calculateTranslateY(
    double scrollOffset,
    double cardOffset,
    double halfStep,
  ) {
    final scrollProgress = (scrollOffset - cardOffset) / halfStep;
    final clamped = scrollProgress.clamp(0.0, 9.0);
    return -clamped * 140;
  }
}

class _StackedCard extends StatelessWidget {
  const _StackedCard({
    required this.section,
    required this.screenHeight,
    required this.cardOffset,
    required this.translateY,
    required this.isCurrentSection,
    required this.sectionProgress,
  });

  final Widget section;
  final double screenHeight;
  final double cardOffset;
  final double translateY;
  final bool isCurrentSection;
  final double sectionProgress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: cardOffset + translateY,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: screenHeight,
        decoration: BoxDecoration(
          // Optional: Add visual feedback for current section
          border: isCurrentSection
              ? Border.all(color: Colors.white.withOpacity(0.3), width: 2)
              : null,
        ),
        child: section,
      ),
    );
  }
}
