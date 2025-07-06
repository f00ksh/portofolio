import 'package:flutter/material.dart';

class AnimationUtils {
  static AnimationController createController({
    required Duration duration,
    required TickerProvider vsync,
  }) {
    return AnimationController(duration: duration, vsync: vsync);
  }

  static Animation<double> createFadeAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  static Animation<double> createSlideAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
  }

  static Animation<double> createFloatingAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }
}
