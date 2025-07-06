// portfolio_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/cards/about/about_section_card.dart';
import 'package:portfolio_web/cards/award/award_section.dart';
import 'package:portfolio_web/cards/contact/contact_section_card.dart';
import 'package:portfolio_web/cards/home/hero_section_card.dart';
import 'package:portfolio_web/cards/projects/projects_section_card.dart';
import 'package:portfolio_web/cards/skills/newflame.dart';
import 'package:portfolio_web/navigation/portfolio_navigation.dart';
import 'package:portfolio_web/providers/scrolling_providers.dart';

class PortfolioHomePage extends ConsumerStatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  ConsumerState<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends ConsumerState<PortfolioHomePage> {
  static const double maxOverlap = 500.0;
  double _lastCalculatedTotalHeight = 0.0;
  double _lastScrollOffset = 0.0;
  
  // Direct widget list instead of sections
  late final List<Widget> _widgets;

  @override
  void initState() {
    super.initState();
    _widgets = [
      const HeroSectionCard(),
      const ExperienceScreen(),
      const GameRectangle(), // Skills section
      const AwardsSectionCard(),
      const ProjectsSectionCard(),
      const ContactSectionCard(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ref.watch(scrollControllerProvider);

    final effectiveScreenHeight = ref.watch(
      effectiveScreenHeightProvider(context),
    );
    
    // Use a more efficient approach to watch totalHeight
    final scrollOffset = ref.watch(scrollOffsetProvider);
    final totalHeight = ref.watch(
      totalHeightProvider(context, _widgets.length),
    );

    // Only update screen height when it actually changes
    if (_lastCalculatedTotalHeight != totalHeight) {
      _lastCalculatedTotalHeight = totalHeight;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(scrollStateNotifierProvider.notifier)
            .updateScreenHeight(effectiveScreenHeight);
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFd661ff),
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          // Navigation SliverAppBar
          const PortfolioSliverNavigation(),

          // Stacked Cards Content
          SliverToBoxAdapter(
            child: SizedBox(
              height: totalHeight - 25,
              child: _buildStackedCards(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedCards(BuildContext context) {
    final scrollState = ref.watch(scrollStateNotifierProvider);
    final screenHeight = ref.watch(effectiveScreenHeightProvider(context));
    final scrollOffset = scrollState.offset;
    final sectionCount = _widgets.length;
    
    // Skip rebuilding if scroll hasn't changed significantly
    if ((scrollOffset - _lastScrollOffset).abs() < 5) {
      return RepaintBoundary(
        child: _buildStackedCardsContent(screenHeight, _lastScrollOffset, sectionCount),
      );
    }
    
    _lastScrollOffset = scrollOffset;
    
    return RepaintBoundary(
      child: _buildStackedCardsContent(screenHeight, scrollOffset, sectionCount),
    );
  }
  
  Widget _buildStackedCardsContent(double screenHeight, double scrollOffset, int sectionCount) {
    double spacingFactor = 1.0;
    if (scrollOffset > 0) {
      spacingFactor =
          0.8 +
          (scrollOffset / (screenHeight * sectionCount)) *
              0.58;

      spacingFactor = spacingFactor.clamp(0.0, .8);
    }

    final baseStride = screenHeight * spacingFactor;
    final halfStep = screenHeight * 0.5;

    return Stack(
      children: List.generate(sectionCount, (i) {
        final revIndex = sectionCount - 1 - i;

        // Calculate card offset
        double cardOffset = 0.0;
        for (int j = 0; j < revIndex; j++) {
          final cardScrollOffset = scrollOffset - (j * baseStride);
          final overlapProgress = (cardScrollOffset / halfStep).clamp(0.0, 1);

          // Add special case handling to match the provider implementation
          double currentOverlap = maxOverlap * (1.0 - overlapProgress);
          if (j == 3) { // Award to Projects transition
            currentOverlap = 0.0;
          }

          cardOffset += baseStride - currentOverlap;
        }

        // Calculate translation
        final scrollProgress = (scrollOffset - cardOffset) / halfStep;
        final clamped = scrollProgress.clamp(0.0, 9.0);
        final translateY = -clamped * 125;

        return Positioned(
          top: cardOffset + translateY,
          left: 0,
          right: 0,
          child: SizedBox(height: screenHeight, child: _widgets[revIndex]),
        );
      }),
    );
  }
}

// Extension to access scroll functionality from anywhere
extension ScrollExtension on WidgetRef {
  void scrollToSection(int sectionIndex) {
    read(scrollStateNotifierProvider.notifier).scrollToSection(sectionIndex);
  }

  void scrollToTop() {
    read(scrollStateNotifierProvider.notifier).scrollToTop();
  }

  double get currentScrollOffset => watch(scrollOffsetProvider);
  int get currentSection => watch(currentSectionProvider);
  bool get isScrolling => watch(isScrollingProvider);
}
