import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RubensRiveAnimation extends StatefulWidget {
  const RubensRiveAnimation({super.key});

  @override
  State<RubensRiveAnimation> createState() => _RubensRiveAnimationState();
}

class _RubensRiveAnimationState extends State<RubensRiveAnimation> {
  Artboard? _riveArtboard;
  StateMachineController? _controller;

  // State machine inputs
  SMITrigger? _getCalmTrigger;
  SMITrigger? _getMadTrigger;
  SMITrigger? _blinkTrigger;
  SMITrigger? _mouthSpeakingTrigger;
  SMITrigger? _idleTrigger;
  SMINumber? _horizontalInput;
  SMINumber? _verticalInput;

  // Missing variables
  bool _isVisible = false;
  Timer? _blinkThrottleTimer;
  Timer? _eyeMovementThrottleTimer;

  static const String _riveAssetPath = 'assets/animations/Avatar.riv';
  static const String _stateMachineName = 'State Machine 1';

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    try {
      final data = await RiveFile.asset(_riveAssetPath);
      final artboard = data.mainArtboard;

      final controller = StateMachineController.fromArtboard(
        artboard,
        _stateMachineName,
      );

      if (controller != null) {
        artboard.addController(controller);
        _initializeStateMachineInputs(controller);

        if (mounted) {
          setState(() {
            _riveArtboard = artboard;
            _controller = controller;
          });
        }
      }
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
    }
  }

  void _initializeStateMachineInputs(StateMachineController controller) {
    _getCalmTrigger = controller.findSMI('Gets calm');
    _getMadTrigger = controller.findSMI('Gets mad');
    _blinkTrigger = controller.findSMI('Blink');
    _mouthSpeakingTrigger = controller.findSMI('Mouth speaking');
    _idleTrigger = controller.findSMI('Idle');
    _horizontalInput = controller.findSMI('Horizontal');
    _verticalInput = controller.findSMI('Vertical');
  }

  void _updateEyePosition(Offset localPosition, Size size) {
    if (_horizontalInput == null || _verticalInput == null) return;

    // Throttle eye movement updates
    if (_eyeMovementThrottleTimer?.isActive ?? false) return;

    _eyeMovementThrottleTimer = Timer(const Duration(milliseconds: 16), () {
      final normalizedX = (localPosition.dx / size.width - 0.5) * 2;
      final normalizedY = (localPosition.dy / size.height - 0.5) * 2;

      _horizontalInput!.value = normalizedX.clamp(-1.0, 1.0);
      _verticalInput!.value = normalizedY.clamp(-1.0, 1.0);
    });
  }

  void _onTap() {
    // Throttle blink animations
    if (_blinkThrottleTimer?.isActive ?? false) return;

    _blinkThrottleTimer = Timer(const Duration(milliseconds: 300), () {
      _blinkTrigger?.fire();
    });
  }

  void _resetToIdle() {
    _horizontalInput?.value = 0;
    _verticalInput?.value = 0;
    _idleTrigger?.fire();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _blinkThrottleTimer?.cancel();
    _eyeMovementThrottleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340,
      height: 500,
      child: _riveArtboard == null
          ? const RiveLoadingIndicator()
          : VisibilityDetector(
              key: const Key('rive_animation'),
              onVisibilityChanged: (info) {
                _isVisible = info.visibleFraction > 0.1;
                if (!_isVisible) {
                  _resetToIdle();
                }
              },
              child: RiveGestureHandler(
                riveArtboard: _riveArtboard!,
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                onTap: _onTap,
                onDoubleTap: _onDoubleTap,
                onLongPress: _onLongPress,
                onLongPressEnd: _onLongPressEnd,
                onHover: _onHover,
                onExit: _onExit,
              ),
            ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final localPosition = renderBox.globalToLocal(details.globalPosition);
      _updateEyePosition(localPosition, renderBox.size);
    }
  }

  void _onPanEnd(DragEndDetails details) => _resetToIdle();

  void _onDoubleTap() => _mouthSpeakingTrigger?.fire();

  void _onLongPress() => _getMadTrigger?.fire();

  void _onLongPressEnd(LongPressEndDetails details) => _getCalmTrigger?.fire();

  void _onHover(PointerEvent details) {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final localPosition = renderBox.globalToLocal(details.position);
      _updateEyePosition(localPosition, renderBox.size);
    }
  }

  void _onExit(PointerExitEvent event) => _resetToIdle();
}

class RiveLoadingIndicator extends StatelessWidget {
  const RiveLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class RiveGestureHandler extends StatelessWidget {
  final Artboard riveArtboard;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;
  final VoidCallback onLongPress;
  final Function(LongPressEndDetails) onLongPressEnd;
  final Function(PointerEvent) onHover;
  final Function(PointerExitEvent) onExit;

  const RiveGestureHandler({
    super.key,
    required this.riveArtboard,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
    required this.onDoubleTap,
    required this.onLongPress,
    required this.onLongPressEnd,
    required this.onHover,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onLongPressEnd: onLongPressEnd,
      child: MouseRegion(
        onHover: onHover,
        onExit: onExit,
        child: Rive(
          artboard: riveArtboard,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          enablePointerEvents: true,
        ),
      ),
    );
  }
}
