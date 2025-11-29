import 'package:flutter/material.dart';
import 'package:portfolio_web/models/scroll_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scrolling_providers.g.dart';

typedef ScrollParams = ({int sectionCount, double screenHeight});

@riverpod
class ScrollControllerNotifier extends _$ScrollControllerNotifier {
  late final ScrollController _controller;
  double _lastOffset = 0.0;

  @override
  ScrollState build(ScrollParams params) {
    _controller = ScrollController();
    _controller.addListener(_onScroll);

    ref.onDispose(() {
      _controller.dispose();
    });

    return const ScrollState(
      offset: 0.0,
      currentSection: 0,
      sectionProgress: 0.0,
      isScrolling: false,
      isNavigationVisible: true,
      scrollDirection: 0.0,
    );
  }

  ScrollController get controller => _controller;

  void _onScroll() {
    final offset = _controller.offset;
    final currentSection = _calculateCurrentSection(
      offset,
      params.sectionCount,
      params.screenHeight,
    );
    final sectionProgress = _calculateSectionProgress(
      offset,
      currentSection,
      params.sectionCount,
      params.screenHeight,
    );

    final scrollDirection = offset - _lastOffset;

    final isNavigationVisible = _shouldShowNavigation(scrollDirection, offset);

    state = state.copyWith(
      offset: offset,
      currentSection: currentSection,
      sectionProgress: sectionProgress,
      isNavigationVisible: isNavigationVisible,
      scrollDirection: scrollDirection,
    );

    _lastOffset = offset;
  }

  bool _shouldShowNavigation(double scrollDirection, double offset) {
    if (offset < 100) return true;
    if (scrollDirection.abs() > 5) {
      return scrollDirection < 0;
    }
    return state.isNavigationVisible;
  }

  int _calculateCurrentSection(
    double offset,
    int sectionCount,
    double screenHeight,
  ) {
    if (offset <= 0) return 0;
    final sectionHeight = screenHeight * 0.8;
    final section = (offset / sectionHeight).floor();
    return section.clamp(0, sectionCount - 1);
  }

  double _calculateSectionProgress(
    double offset,
    int currentSection,
    int sectionCount,
    double screenHeight,
  ) {
    if (currentSection >= sectionCount - 1) return 1.0;
    final sectionHeight = screenHeight * 0.8;
    final sectionStart = currentSection * sectionHeight;
    final progress = (offset - sectionStart) / sectionHeight;
    return progress.clamp(0.0, 1.0);
  }

  Future<void> scrollToSection(int sectionIndex, BuildContext context) async {
    if (sectionIndex < 0 || sectionIndex >= params.sectionCount) return;

    final targetOffset = sectionIndex * params.screenHeight * 0.8;

    state = state.copyWith(isScrolling: true, isNavigationVisible: true);

    await _controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );

    state = state.copyWith(isScrolling: false);
  }

  Future<void> scrollToNext(BuildContext context) async {
    if (state.currentSection < params.sectionCount - 1) {
      await scrollToSection(state.currentSection + 1, context);
    }
  }

  Future<void> scrollToPrevious(BuildContext context) async {
    if (state.currentSection > 0) {
      await scrollToSection(state.currentSection - 1, context);
    }
  }
}
