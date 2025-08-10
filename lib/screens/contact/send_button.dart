import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'send_button.g.dart';

class CustomSendButtonAnimated extends ConsumerStatefulWidget {
  const CustomSendButtonAnimated({super.key});

  @override
  @override
  ConsumerState<CustomSendButtonAnimated> createState() =>
      _CustomSendButtonAnimatedState();
}

class _CustomSendButtonAnimatedState
    extends ConsumerState<CustomSendButtonAnimated> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () {
        ref.read(sendStateNotifierProvider.notifier).send();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.07,
        transform: Matrix4.translationValues(
          _isPressed ? 2 : 0,
          _isPressed ? 2 : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF57E89E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(_isPressed ? 2 : 4, _isPressed ? 2 : 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'SEND',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

@riverpod
class SendStateNotifier extends _$SendStateNotifier {
  @override
  bool build() {
    return false;
  }

  void send() {
    state = true;
  }
}
