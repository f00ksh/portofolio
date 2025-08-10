import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkMarquee extends ConsumerStatefulWidget {
  const WorkMarquee({super.key});

  @override
  ConsumerState<WorkMarquee> createState() => _WorkMarqueeState();
}

class _WorkMarqueeState extends ConsumerState<WorkMarquee>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  // Reduce the number of items for better performance
  final List<String> _workList = List.generate(
    20,
    (_) => 'WORK',
  ); // Reduced from 50

  double _lastScrollOffset = 0.0;
  double _basePosition = 0.0; // Accumulated base position
  double _animationOffset = 0.0; // Current animation offset
  double _currentPosition = 0.0;
  Timer? _scrollThrottleTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController =
        AnimationController(
          duration: const Duration(milliseconds: 200),
          vsync: this,
        )..addListener(() {
          setState(() {
            _currentPosition =
                _basePosition + (_animationOffset * _animationController.value);
          });
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    _scrollThrottleTimer?.cancel();
    super.dispose();
  }

  void _handleScrollChange(double currentOffset) {
    // Throttle scroll handling
    if (_scrollThrottleTimer?.isActive ?? false) return;

    _scrollThrottleTimer = Timer(const Duration(milliseconds: 16), () {
      final scrollDelta = currentOffset - _lastScrollOffset;

      // Only process significant changes
      if (scrollDelta.abs() > 10) {
        // Increased threshold
        // Update base position with the previous animation
        _basePosition = _currentPosition;

        // Set new animation offset
        _animationOffset = scrollDelta.clamp(-30.0, 50.0);

        _animationController.reset();
        _animationController.forward();
      }

      _lastScrollOffset = currentOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to scroll changes
    // ref.listen(
    //   scrollControllerManagerProvider.select((state) => state.offset),
    //   (previous, current) {
    //     _handleScrollChange(current);
    //   },
    // );

    return Transform.rotate(
      angle: -0.04,
      child: Container(
        height: 125,
        width: MediaQuery.of(context).size.width * 2,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 2),
            bottom: BorderSide(width: 2),
          ),
          color: Color(0xFFFFC107),
        ),
        child: ClipRect(
          child: OverflowBox(
            maxWidth: double.infinity,
            child: Transform.translate(
              offset: Offset(_currentPosition, 0),
              child: Row(
                children: List.generate(
                  _workList.length,
                  (index) => Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _workList[index],
                      style: GoogleFonts.blackOpsOne(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        height: .6,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
