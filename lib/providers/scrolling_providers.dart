// scroll_providers.dart
import 'package:flutter/material.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async' show Timer;

// Removed memoize import as it's no longer needed
part 'scrolling_providers.freezed.dart';
part 'scrolling_providers.g.dart';

@freezed
sealed class ScrollState with _$ScrollState {
  const factory ScrollState({
    @Default(0.0) double offset,
    @Default(0.0) double screenHeight,
    @Default(false) bool isScrolling,
    @Default(0) int currentSectionIndex,
  }) = _ScrollState;
}

// Global scroll controller provider
@riverpod
class ScrollController extends _$ScrollController {
  late final flutter.ScrollController _controller;

  @override
  flutter.ScrollController build() {
    _controller = flutter.ScrollController();

    // Listen to scroll events
    _controller.addListener(() {
      if (_controller.hasClients) {
        ref
            .read(scrollStateNotifierProvider.notifier)
            .updateOffset(_controller.offset);
      }
    });

    // Dispose when provider is disposed
    ref.onDispose(() {
      _controller.dispose();
    });

    return _controller;
  }
}

// Scroll state provider
@riverpod
class ScrollStateNotifier extends _$ScrollStateNotifier {
  Timer? _scrollThrottleTimer;
  Timer? _sectionUpdateThrottleTimer;
  int _lastCalculatedSection = 0;
  double _lastProcessedOffset = 0.0;

  @override
  ScrollState build() {
    return const ScrollState();
  }

  void updateOffset(double offset) {
    // Update the offset immediately for smooth UI
    state = state.copyWith(offset: offset);

    // Throttle the expensive section calculation
    if (_sectionUpdateThrottleTimer?.isActive ?? false) return;

    // Only recalculate if we've scrolled at least 5 pixels
    if ((offset - _lastProcessedOffset).abs() < 5) return;

    _lastProcessedOffset = offset;
    _sectionUpdateThrottleTimer = Timer(const Duration(milliseconds: 50), () {
      _updateCurrentSectionFromOffset(offset);
    });
  }

  void updateScreenHeight(double height) {
    state = state.copyWith(screenHeight: height);
  }

  void updateScrolling(bool isScrolling) {
    state = state.copyWith(isScrolling: isScrolling);
  }

  void updateCurrentSection(int index) {
    state = state.copyWith(currentSectionIndex: index);
  }

  void _updateCurrentSectionFromOffset(double offset) {
    final screenHeight = state.screenHeight;
    if (screenHeight == 0) return;

    // Calculate current section based on offset with sophisticated logic
    const sectionCount = 6;
    const double maxOverlap = 360.0;
    const double spacingFactorBase = 0.8;
    const double spacingFactorRange = 0.58;

    // Calculate spacing factor
    double spacingFactor = 1.0;
    if (offset > 0) {
      spacingFactor =
          spacingFactorBase +
          (offset / (screenHeight * sectionCount)) * spacingFactorRange;
      spacingFactor = spacingFactor.clamp(0.0, 0.8);
    }

    final baseStride = screenHeight * spacingFactor;
    final halfStep = screenHeight * 0.5;

    // Find current section by checking which section range the offset falls into
    int currentSection = 0;
    double accumulatedOffset = 0.0;

    for (int i = 0; i < sectionCount; i++) {
      double nextSectionOffset = accumulatedOffset;

      if (i == 0) {
        nextSectionOffset += baseStride;
      } else {
        final cardScrollOffset = offset - ((i - 1) * baseStride);
        final overlapProgress = (cardScrollOffset / halfStep).clamp(0.0, 1.0);

        double currentOverlap = maxOverlap * (1.0 - overlapProgress);
        if (i == 3) {
          currentOverlap = 0.0; // No overlap between Award and Projects
        }

        nextSectionOffset += baseStride - currentOverlap;
      }

      if (offset < nextSectionOffset) {
        currentSection = i;
        break;
      }

      accumulatedOffset = nextSectionOffset;
      if (i == sectionCount - 1) {
        currentSection = i;
      }
    }

    // Only update if section changed to avoid unnecessary rebuilds
    if (currentSection != _lastCalculatedSection) {
      _lastCalculatedSection = currentSection;
      state = state.copyWith(currentSectionIndex: currentSection);
    }
  }

  void updateFromScroll(double offset, double screenHeight) {
    // Throttle updates to reduce calculations
    if (_scrollThrottleTimer?.isActive ?? false) return;

    _scrollThrottleTimer = Timer(const Duration(milliseconds: 16), () {
      state = state.copyWith(
        offset: offset,
        screenHeight: screenHeight,
        isScrolling: true,
      );

      // Update current section based on the new offset
      _updateCurrentSectionFromOffset(offset);
    });
  }

  // Scroll to specific section with corrected calculation
  void scrollToSection(int index) {
    final controller = ref.read(scrollControllerProvider);
    final screenHeight = state.screenHeight;

    if (screenHeight == 0) return;

    // Constants matching your implementation
    const double maxOverlap = 360.0;
    const double spacingFactorBase = 0.8;
    const double spacingFactorRange = 0.58;
    const sectionCount = 6;

    // Calculate target offset for the section
    double targetOffset = 0.0;

    if (index == 0) {
      // First section is at the top
      targetOffset = 0.0;
    } else {
      // For subsequent sections, calculate the accumulated offset
      double accumulatedOffset = 0.0;

      // Calculate spacing factor based on current scroll position
      final currentScrollOffset = controller.hasClients
          ? controller.offset
          : 0.0;
      double spacingFactor = 1.0;
      if (currentScrollOffset > 0) {
        spacingFactor =
            spacingFactorBase +
            (currentScrollOffset / (screenHeight * sectionCount)) *
                spacingFactorRange;
        spacingFactor = spacingFactor.clamp(0.0, 0.8);
      }

      final baseStride = screenHeight * spacingFactor;
      final halfStep = screenHeight * 0.5;

      // Calculate offset for each section up to the target
      for (int i = 1; i <= index; i++) {
        if (i == 1) {
          // First transition
          accumulatedOffset += baseStride;
        } else {
          // Calculate overlap for this section
          final cardScrollOffset = currentScrollOffset - ((i - 2) * baseStride);
          final overlapProgress = (cardScrollOffset / halfStep).clamp(0.0, 1.0);

          double currentOverlap = maxOverlap * (1.0 - overlapProgress);
          if (i == 4) {
            // Award to Projects transition (index 3 to 4)
            currentOverlap = 0.0;
          }

          accumulatedOffset += baseStride - currentOverlap;
        }
      }

      targetOffset = accumulatedOffset;
    }

    // Smooth scroll to the calculated position
    controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  // Scroll to top
  void scrollToTop() {
    final controller = ref.read(scrollControllerProvider);
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  // @override
  // void dispose() {
  //   _scrollThrottleTimer?.cancel();
  //   _sectionUpdateThrottleTimer?.cancel();
  //   super.dispose();
  // }
}

// Computed providers for derived state
@riverpod
double scrollOffset(Ref ref) {
  return ref.watch(scrollStateNotifierProvider.select((state) => state.offset));
}

@riverpod
int currentSection(Ref ref) {
  return ref.watch(
    scrollStateNotifierProvider.select((state) => state.currentSectionIndex),
  );
}

@riverpod
bool isScrolling(Ref ref) {
  return ref.watch(
    scrollStateNotifierProvider.select((state) => state.isScrolling),
  );
}

// Provider for effective screen height calculation
@riverpod
double effectiveScreenHeight(Ref ref, BuildContext context) {
  const heightMultiplier = 1;
  return MediaQuery.of(context).size.height * heightMultiplier;
}

@riverpod
double totalHeight(Ref ref, BuildContext context, int widgetCount) {
  final scrollState = ref.watch(scrollStateNotifierProvider);
  final screenHeight = ref.watch(effectiveScreenHeightProvider(context));
  final scrollOffset = scrollState.offset;

  // Direct calculation without memoization
  const maxOverlap = 500.0;

  double spacingFactor = 1.0;
  if (scrollOffset > 0) {
    spacingFactor = 0.8 + (scrollOffset / (screenHeight * widgetCount)) * 0.58;
    spacingFactor = spacingFactor.clamp(0.0, 0.8);
  }

  final baseStride = screenHeight * spacingFactor;
  final halfStep = screenHeight * 0.5;
  double totalHeight = screenHeight;

  for (int i = 1; i < widgetCount; i++) {
    final cardScrollOffset = scrollOffset - ((i - 1) * baseStride);
    final overlapProgress = (cardScrollOffset / halfStep).clamp(0.0, 1.0);

    // Add special case handling to match other implementations
    double currentOverlap = maxOverlap * (1.0 - overlapProgress);
    if (i == 4) {
      // Award to Projects transition
      currentOverlap = 0.0;
    }

    totalHeight += baseStride - currentOverlap;
  }

  return totalHeight;
}

// Global scroll to top function
void scrollToTop(WidgetRef ref) {
  final controller = ref.read(scrollControllerProvider);
  controller.animateTo(
    0,
    duration: const Duration(milliseconds: 800),
    curve: Curves.easeInOut,
  );
}
