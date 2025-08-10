import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_web/screens/skills/game/forge2d_game.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GameArea extends StatelessWidget {
  final Forge2DExample game;
  final Function(bool) onVisibilityChanged;

  const GameArea({
    super.key,
    required this.game,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: VisibilityDetector(
        key: const Key('game_rectangle'),
        onVisibilityChanged: (info) {
          onVisibilityChanged(info.visibleFraction > 0.1);
        },
        child: GameWidget.controlled(
          gameFactory: () => game,
          backgroundBuilder: (context) => const GameBackground(),
        ),
      ),
    );
  }
}

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(decoration: const BoxDecoration(color: Color(0xffffcb46)));
  }
}
