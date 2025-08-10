import 'package:flutter/material.dart';
import 'package:portfolio_web/screens/skills/game/forge2d_game.dart';
import 'package:portfolio_web/screens/skills/game/game_area.dart';
import 'package:portfolio_web/screens/skills/header.dart';

class GameRectangle extends StatefulWidget {
  const GameRectangle({super.key});

  @override
  State<GameRectangle> createState() => _GameRectangleState();
}

class _GameRectangleState extends State<GameRectangle>
    with WidgetsBindingObserver {
  late final Forge2DExample _game;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _game = Forge2DExample();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _game.setVisibility(false);
    } else if (state == AppLifecycleState.resumed) {
      _game.setVisibility(_isVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GameContainer(
      height: height,
      game: _game,
      onVisibilityChanged: (isVisible) {
        _isVisible = isVisible;
        _game.setVisibility(_isVisible);
      },
    );
  }
}

class GameContainer extends StatelessWidget {
  final double height;
  final Forge2DExample game;
  final Function(bool) onVisibilityChanged;

  const GameContainer({
    super.key,
    required this.height,
    required this.game,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffffcb46),
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black, width: 3),
        ),
      ),
      height: height,
      child: Column(
        children: [
          const SizedBox(height: 80),
          const GameHeader(),
          const SizedBox(height: 20),
          GameArea(game: game, onVisibilityChanged: onVisibilityChanged),
        ],
      ),
    );
  }
}
