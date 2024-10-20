import 'package:flutter/material.dart';

// Definition of a widget that can apply a bouncing animation

class BouncingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double scaleFactor;
  final void Function()? onPressed;

  const BouncingWidget({
    super.key,
    required this.child,
    this.scaleFactor = 0.98,
    this.onPressed,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<BouncingWidget> createState() => _BouncingWidgetState();
}

class _BouncingWidgetState extends State<BouncingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  // Execute animation on tap down
  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  // Reset animation when tap ends
  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onPressed?.call();
  }

  // Reverse animation on tap cancel
  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    // Set up scale animation (bouncing effect)
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _onTapDown, // Tap start
        onTapUp: _onTapUp, // Tap end
        onTapCancel: _onTapCancel, // Tap cancel
        child: ScaleTransition(
          scale: _scaleAnimation, // Apply animation
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of animation controller
    _controller.dispose();
    super.dispose();
  }
}
