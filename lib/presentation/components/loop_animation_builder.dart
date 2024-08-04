import 'package:flutter/material.dart';

class LoopAnimationBuilder<T> extends StatefulWidget {
  const LoopAnimationBuilder({
    super.key,
    required this.tween,
    required this.builder,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.linear,
  });

  final Animatable<T> tween;
  final Widget Function(BuildContext context, Widget? child, T alpha) builder;
  final Widget child;
  final Duration duration;
  final Curve curve;

  @override
  State<LoopAnimationBuilder<T>> createState() => _LoopAnimationBuilderState<T>();
}

class _LoopAnimationBuilderState<T> extends State<LoopAnimationBuilder<T>> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void initState() {
    super.initState();
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _animationController.repeat();
        }
      },
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => widget.builder(context, child, _animationController.drive(widget.tween).value),
      child: widget.child,
    );
  }
}
