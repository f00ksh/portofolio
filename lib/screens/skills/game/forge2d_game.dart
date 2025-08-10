import 'dart:async' as async;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:portfolio_web/screens/skills/game/components/shape_shifting_object.dart';
import 'package:portfolio_web/screens/skills/game/components/wall.dart';

class Forge2DExample extends Forge2DGame {
  final int objectCount = 15; // Reduced for web performance
  bool _isPaused = false;
  bool _isVisible = true;
  late Body groundBody;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _addObjectsWithStaggeredDelay();
    camera.viewfinder.zoom = 6;
    world.addAll(_createBoundaries());
    groundBody = world.createBody(BodyDef());
  }

  void _addObjectsWithStaggeredDelay() {
    for (int i = 0; i < objectCount; i++) {
      async.Timer(Duration(milliseconds: i * 300), () {
        if (_isVisible) {
          final object = ShapeShiftingObject(shouldApplyThrowEffect: true);
          world.add(object);
        }
      });
    }
  }

  void setVisibility(bool isVisible) {
    _isVisible = isVisible;
    if (!_isVisible && !_isPaused) {
      pauseEngine();
      _isPaused = true;
    } else if (_isVisible && _isPaused) {
      resumeEngine();
      _isPaused = false;
    }
  }

  List<Component> _createBoundaries() {
    final visibleRect = camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft),
    ];
  }
}
