import 'package:freezed_annotation/freezed_annotation.dart';

part 'scroll_state.freezed.dart';

@freezed
abstract class ScrollState with _$ScrollState {
  const factory ScrollState({
    required double offset,
    required int currentSection,
    required double sectionProgress,
    required bool isScrolling,
    required bool isNavigationVisible,
    required double scrollDirection,
  }) = _ScrollState;
}
