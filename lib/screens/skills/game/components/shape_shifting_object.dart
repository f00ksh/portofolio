import 'dart:async' as async;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_web/models/tech_stack.dart';
import 'package:portfolio_web/screens/skills/game/colors.dart';

enum Shapes { circle, rectangle, star, fourLeafClover, sunny }

// Add this import at the top of the file

class ShapeShiftingObject extends BodyComponent
    with DragCallbacks, TapCallbacks {
  final TechStack techStack;
  final Random _random = Random();

  late Color objectColor;
  late Shapes shape;
  async.Timer? _shapeTimer;
  bool _hasAppliedInitialEffect = false;

  // Replace TextPainter with SVG related fields
  ui.Picture? _svgPicture;
  double _svgSize = 0;
  bool _isSvgLoaded = false;
  static const double width = 16.0;
  static const double height = 16.0;
  static const double borderRadius = 6.0;
  double _svgWidth = 0; // Add these to store dimensions
  double _svgHeight = 0;

  ShapeShiftingObject({
    Vector2? initialPosition,
    bool shouldApplyThrowEffect = false,
  }) : techStack = techStackList[Random().nextInt(techStackList.length)],
       super(
         fixtureDefs: [
           FixtureDef(
             PolygonShape()..setAsBoxXY(width, height),
             density: 0.6,
             restitution: 0.8,
             friction: 0.5,
           ),
         ],
         bodyDef: BodyDef(
           angularDamping: 0.8,
           position: Vector2(-20 + Random().nextDouble() * 80, -50),
           type: BodyType.dynamic,
           gravityScale: Vector2.all(1.2),
         ),
       ) {
    // Initialize with random color
    objectColor = colorList[_random.nextInt(colorList.length)];
    shape = Shapes.values[_random.nextInt(Shapes.values.length)];

    // Load SVG instead of using TextPainter
    _loadSvg();

    _startRandomShapeShifting();

    if (shouldApplyThrowEffect) {
      _applyThrowEffect();
    }
  }

  // Add this method to load SVG
  Future<void> _loadSvg() async {
    // This is the correct syntax from the documentation
    final PictureInfo pictureInfo = await vg.loadPicture(
      SvgAssetLoader(techStack.svgPath),
      null,
    );

    _svgPicture = pictureInfo.picture;
    _svgSize = width * 0.8;
    _svgWidth = pictureInfo.size.width; // Store the width
    _svgHeight = pictureInfo.size.height; // Store the height
    _isSvgLoaded = true;

    // Important: dispose when done
    // pictureInfo.picture.dispose(); // Only dispose when you're completely done with it
  }

  void _scheduleNextShapeShift() {
    _shapeTimer?.cancel();
    _shapeTimer = async.Timer(Duration(seconds: 4 + _random.nextInt(3)), () {
      _applyShapeChangePhysics();
      // Change both shape and color
      shape = Shapes.values[_random.nextInt(Shapes.values.length)];
      objectColor = colorList[_random.nextInt(colorList.length)];
      _scheduleNextShapeShift();
    });
  }

  @override
  bool onTapDown(TapDownEvent event) {
    // Change both shape and color on tap
    shape = Shapes.values[_random.nextInt(Shapes.values.length)];
    objectColor = colorList[_random.nextInt(colorList.length)];
    _applyTapPhysics();
    return true;
  }

  void _applyShapeChangePhysics() {
    final selfImpulse = Vector2(
      (-1.5 + _random.nextDouble() * 3) * 40, // Reduced force for web
      (-1.5 + _random.nextDouble() * 3) * 40,
    );
    body.applyLinearImpulse(selfImpulse);
    body.angularVelocity += (-0.5 + _random.nextDouble() * 1) * pi;
    _affectNearbyObjects();
  }

  void _affectNearbyObjects() {
    final currentPosition = body.position;
    final affectRadius = 25.0; // Reduced radius for performance
    final world = this.world;
    final allBodies = <Body>[];

    // Optimized body iteration
    var bodies = world.physicsWorld.bodies;
    allBodies.addAll(bodies);

    // Limit affected objects for performance
    int affectedCount = 0;
    const maxAffectedObjects = 5;

    for (final otherBody in allBodies) {
      if (otherBody == body || affectedCount >= maxAffectedObjects) continue;

      final distance = currentPosition.distanceTo(otherBody.position);

      if (distance < affectRadius && distance > 0) {
        final forceStrength = (affectRadius - distance) / affectRadius;
        final direction = (otherBody.position - currentPosition).normalized();
        final impulse = direction * forceStrength * 150; // Reduced force
        otherBody.applyLinearImpulse(impulse);

        final angularImpulse =
            (-0.5 + _random.nextDouble() * 1) * pi * forceStrength;
        otherBody.angularVelocity += angularImpulse;

        affectedCount++;
      }
    }
  }

  void _applyTapPhysics() {
    final tapImpulse = Vector2(
      (-2 + _random.nextDouble() * 4) * 80, // Reduced force for web
      (-2 + _random.nextDouble() * 4) * 80,
    );
    body.applyLinearImpulse(tapImpulse);
    body.angularVelocity += (-1 + _random.nextDouble() * 2) * pi;
  }

  void _applyThrowEffect() {
    async.Timer(const Duration(milliseconds: 100), () {
      if (!_hasAppliedInitialEffect) {
        _hasAppliedInitialEffect = true;

        final horizontalForce = (-3 + Random().nextDouble() * 12) * 80;
        final verticalForce = (10 + Random().nextDouble() * 15) * 80;

        body.applyLinearImpulse(Vector2(horizontalForce, verticalForce));

        final angularVelocity = (-2 + Random().nextDouble() * 4) * pi;
        body.angularVelocity = angularVelocity;
      }
    });
  }

  void _startRandomShapeShifting() {
    _shapeTimer?.cancel();
    _scheduleNextShapeShift();
  }

  @override
  void onRemove() {
    _shapeTimer?.cancel();
    super.onRemove();
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = objectColor
      ..style = PaintingStyle.fill;

    // Render shape
    _renderShape(canvas, paint);

    // Render SVG icon
    if (_isSvgLoaded && _svgPicture != null) {
      canvas.save();
      // Position the SVG in the center of the shape
      canvas.translate(-_svgSize / 2, -_svgSize / 2 - width * 0.2);
      // Scale the SVG to fit using stored dimensions
      canvas.scale(
        _svgSize / _svgWidth, // Use stored width
        _svgSize / _svgHeight, // Use stored height
      );
      canvas.drawPicture(_svgPicture!);
      canvas.restore();
    } else {
      // Fallback if SVG isn't loaded
      final iconPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(0, -width * 0.2), width * 0.3, iconPaint);
    }
  }

  void _renderShape(Canvas canvas, Paint paint) {
    switch (shape) {
      case Shapes.circle:
        canvas.drawCircle(Offset.zero, width, paint);
        break;
      case Shapes.rectangle:
        final rect = Rect.fromCenter(
          center: Offset.zero,
          width: width * 1.8,
          height: height * 1.8,
        );
        final rrect = RRect.fromRectAndRadius(
          rect,
          const Radius.circular(borderRadius),
        );
        canvas.drawRRect(rrect, paint);
        break;
      case Shapes.star:
        _renderStar(canvas, paint);
        break;
      case Shapes.fourLeafClover:
        _renderFourLeafClover(canvas, paint);
        break;
      case Shapes.sunny:
        _renderSunny(canvas, paint);
        break;
    }
  }

  void _renderStar(Canvas canvas, Paint paint) {
    final path = Path();
    const center = Offset.zero;
    const radius = width * 1.3;
    const numberOfLobes = 8;
    const lobeDepth = 0.3;

    for (var i = 0; i <= numberOfLobes; i++) {
      final angle = 2 * pi * i / numberOfLobes;
      final x = center.dx + cos(angle) * radius * (1 - lobeDepth);
      final y = center.dy + sin(angle) * radius * (1 - lobeDepth);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevAngle = 2 * pi * (i - 1) / numberOfLobes;
        final midAngle = (prevAngle + angle) / 2;
        final controlX = center.dx + cos(midAngle) * radius;
        final controlY = center.dy + sin(midAngle) * radius;

        path.quadraticBezierTo(controlX, controlY, x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  void _renderFourLeafClover(Canvas canvas, Paint paint) {
    final path = Path();
    const center = Offset.zero;
    const radius = width / 1.8;

    final leafCenters = [
      Offset(center.dx - radius * 0.7, center.dy - radius * 0.7),
      Offset(center.dx + radius * 0.7, center.dy - radius * 0.7),
      Offset(center.dx - radius * 0.7, center.dy + radius * 0.7),
      Offset(center.dx + radius * 0.7, center.dy + radius * 0.7),
    ];

    for (var leafCenter in leafCenters) {
      path.addOval(Rect.fromCircle(center: leafCenter, radius: radius));
    }

    canvas.drawPath(path, paint);
  }

  void _renderSunny(Canvas canvas, Paint paint) {
    final path = Path();
    const center = Offset.zero;
    const radius = width * 1.33;
    const numberOfLobes = 6;
    const lobeDepth = 0.4;

    for (var i = 0; i <= numberOfLobes; i++) {
      final angle = 2 * pi * i / numberOfLobes;
      final x = center.dx + cos(angle) * radius * (1 - lobeDepth);
      final y = center.dy + sin(angle) * radius * (1 - lobeDepth);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        final prevAngle = 2 * pi * (i - 1) / numberOfLobes;
        final midAngle = (prevAngle + angle) / 2;
        final controlX = center.dx + cos(midAngle) * radius;
        final controlY = center.dy + sin(midAngle) * radius;

        path.quadraticBezierTo(controlX, controlY, x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    body.applyLinearImpulse(event.canvasDelta * 200); // Reduced force
  }
}
