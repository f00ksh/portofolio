import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart' hide Transform;
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:async' as async;

class GameRectangle extends StatefulWidget {
  const GameRectangle({super.key});

  @override
  State<GameRectangle> createState() => _GameRectangleState();
}

class _GameRectangleState extends State<GameRectangle>
    with WidgetsBindingObserver {
  final Forge2DExample _game = Forge2DExample();
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
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
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffffcb46),
        border: Border.all(color: Colors.black, width: 3),
      ),
      height: height,
      child: Column(
        children: [
          SizedBox(height: 20), // Reduced from Spacer(flex: 2)
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xffef476f),
              border: Border.all(color: Colors.black, width: 3),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(4, 4),
                  color: Colors.black.withOpacity(0.8),
                ),
              ],
            ),
            child: FittedBox(
              // Added FittedBox to ensure text scales down if needed
              fit: BoxFit.scaleDown,
              child: Text(
                "Tecnolgy & Skills",
                style: GoogleFonts.anton(
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(height: 20), // Reduced from Spacer(flex: 1)
          Expanded(
            // Changed from fixed height to Expanded
            child: VisibilityDetector(
              key: const Key('game_rectangle'),
              onVisibilityChanged: (info) {
                _isVisible = info.visibleFraction > 0.1;
                _game.setVisibility(_isVisible);
              },
              child: GameWidget.controlled(
                gameFactory: () => _game,
                backgroundBuilder: (context) => Container(
                  decoration: BoxDecoration(color: Color(0xffffcb46)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Forge2DExample extends Forge2DGame {
  // Reduce object count for better performance
  final int objectCount = 8; // Reduced from 15
  final double minX = 10;
  final double maxX = 200;
  final double topY = 0;
  bool _isPaused = false;
  bool _isVisible = true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Create fewer objects
    for (int i = 0; i < objectCount / 2; i++) {
      world.add(ShapeShiftingObject()); // Use the new shape-shifting object
    }

    camera.viewfinder.zoom = 6;
    world.addAll(createBoundaries());
  }

  // Add visibility control to pause physics when off-screen
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

  List<Component> createBoundaries() {
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

class Ball extends BodyComponent with DragCallbacks, TapCallbacks {
  Color ballColor;
  final double ballRadius;
  final Random _random = Random();

  // Predefined color list

  Ball({Vector2? initialPosition, Color? initialColor, this.ballRadius = 14.0})
    : ballColor = initialColor ?? colorList[Random().nextInt(colorList.length)],
      super(
        fixtureDefs: [
          FixtureDef(
            CircleShape()..radius = ballRadius,
            density: .6,
            restitution: 0.8,
            friction: 0.5,
          ),
        ],
        bodyDef: BodyDef(
          angularDamping: 0.8,
          position: initialPosition ?? Vector2.zero(),
          type: BodyType.dynamic,
          gravityScale: Vector2.all(1.2),
        ),
      );

  // Function to get random color from the color list
  Color getRandomColor() {
    return colorList[_random.nextInt(colorList.length)];
  }

  // Function to change ball color to a random one
  void changeToRandomColor() {
    Color newColor;
    do {
      newColor = getRandomColor();
    } while (newColor == ballColor &&
        colorList.length > 1); // Ensure different color

    ballColor = newColor;
  }

  @override
  void render(Canvas canvas) {
    // Create paint for the ball
    final paint = Paint()
      ..color = ballColor
      ..style = PaintingStyle.fill;

    // Draw the circle
    canvas.drawCircle(
      Offset.zero, // Center at body position
      ballRadius,
      paint,
    );
  }

  @override
  bool onTapDown(TapDownEvent event) {
    // Change color when tapped
    changeToRandomColor();
    return true; // Consume the event
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    body.applyLinearImpulse(event.canvasDelta * 300);
  }
}

class Rectangle extends BodyComponent with DragCallbacks, TapCallbacks {
  Color rectangleColor;
  final double width;
  final double height;
  final double borderRadius;
  final Random _random = Random();

  Rectangle({
    Vector2? initialPosition,
    Color? initialColor,
    this.width = 14.0,
    this.height = 14.0,
    this.borderRadius = 4.0, // Default border radius
  }) : rectangleColor =
           initialColor ?? colorList[Random().nextInt(colorList.length)],
       super(
         fixtureDefs: [
           FixtureDef(
             PolygonShape()..setAsBoxXY(width, height),
             density: .6,
             restitution: 0.8,
             friction: 0.5,
           ),
         ],
         bodyDef: BodyDef(
           angularDamping: 0.8,
           position: initialPosition ?? Vector2.zero(),
           type: BodyType.dynamic,
           gravityScale: Vector2.all(1.2),
         ),
       );

  // Function to get random color from the color list
  Color getRandomColor() {
    return colorList[_random.nextInt(colorList.length)];
  }

  // Function to change rectangle color to a random one
  void changeToRandomColor() {
    Color newColor;
    do {
      newColor = getRandomColor();
    } while (newColor == rectangleColor &&
        colorList.length > 1); // Ensure different color

    rectangleColor = newColor;
  }

  @override
  void render(Canvas canvas) {
    // Create paint for the rectangle
    final paint = Paint()
      ..color = rectangleColor
      ..style = PaintingStyle.fill;

    // Create rounded rectangle
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: width * 2, // setAsBoxXY uses half-width/half-height
      height: height * 2,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Draw the rounded rectangle
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    // Change color when tapped
    changeToRandomColor();
    return true; // Consume the event
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    body.applyLinearImpulse(event.canvasDelta * 300);
  }
}

class Wall extends BodyComponent {
  final Vector2 _start;
  final Vector2 _end;

  Wall(this._start, this._end);

  @override
  Body createBody() {
    final shape = EdgeShape()..set(_start, _end);
    final fixtureDef = FixtureDef(shape, friction: 0.2);
    final bodyDef = BodyDef(position: Vector2.zero());

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void render(Canvas canvas) {
    // Optional: Draw visible wall for debugging
    final paint = Paint()
      ..color = const Color(0xffffcb46)
      ..strokeWidth = 0.5;

    canvas.drawLine(Offset(_start.x, _start.y), Offset(_end.x, _end.y), paint);
  }
}

class ShapeShiftingObject extends BodyComponent
    with DragCallbacks, TapCallbacks {
  Color objectColor;
  double width;
  double height;
  double borderRadius;
  final Random _random = Random();
  bool _isCircle = false;
  async.Timer? _shapeTimer;

  ShapeShiftingObject({
    Vector2? initialPosition,
    Color? initialColor,
    this.width = 14.0,
    this.height = 14.0,
    this.borderRadius = 4.0,
  }) : objectColor =
           initialColor ?? colorList[Random().nextInt(colorList.length)],
       super(
         fixtureDefs: [
           FixtureDef(
             PolygonShape()..setAsBoxXY(width, height),
             density: .6,
             restitution: 0.8,
             friction: 0.5,
           ),
         ],
         bodyDef: BodyDef(
           angularDamping: 0.8,
           position: initialPosition ?? Vector2.zero(),
           type: BodyType.dynamic,
           gravityScale: Vector2.all(1.2),
         ),
       ) {
    _startRandomShapeShifting();
  }

  void _startRandomShapeShifting() {
    _shapeTimer?.cancel();
    _scheduleNextShapeShift();
  }

  void _scheduleNextShapeShift() {
    // Random delay between 3 to 8 seconds
    final randomDelay = 3000 + _random.nextInt(5000);
    _shapeTimer = async.Timer(Duration(milliseconds: randomDelay), () {
      if (_random.nextBool()) {
        // 50% chance to change shape
        _isCircle = !_isCircle;
        changeToRandomColor(); // Optional: change color with shape
      }
      _scheduleNextShapeShift(); // Schedule next potential change
    });
  }

  @override
  void onRemove() {
    _shapeTimer?.cancel();
    super.onRemove();
  }

  Color getRandomColor() {
    return colorList[_random.nextInt(colorList.length)];
  }

  void changeToRandomColor() {
    Color newColor;
    do {
      newColor = getRandomColor();
    } while (newColor == objectColor && colorList.length > 1);
    objectColor = newColor;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = objectColor
      ..style = PaintingStyle.fill;

    if (_isCircle) {
      // Draw circle
      canvas.drawCircle(
        Offset.zero,
        width, // Use width as radius
        paint,
      );
    } else {
      // Draw rounded rectangle
      final rect = Rect.fromCenter(
        center: Offset.zero,
        width: width * 2,
        height: height * 2,
      );
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.circular(borderRadius),
      );
      canvas.drawRRect(rrect, paint);
    }
  }

  @override
  bool onTapDown(TapDownEvent event) {
    changeToRandomColor();
    return true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    body.applyLinearImpulse(event.canvasDelta * 300);
  }
}

final List<Color> colorList = [
  const Color(0xFF4CAF50), // Green
  const Color(0xFFF44336), // Red
  const Color(0xFF2196F3), // Blue

  const Color(0xFF9C27B0), // Purple

  const Color(0xFF00BCD4), // Cyan
  const Color(0xFFE91E63), // Pink
  const Color(0xFF607D8B), // Blue Grey
  const Color(0xFF8BC34A), // Light Green
  const Color(0xFFFF5722), // Deep Orange
  const Color(0xFF673AB7), // Deep Purple
  const Color(0xFF009688), // Teal
];
