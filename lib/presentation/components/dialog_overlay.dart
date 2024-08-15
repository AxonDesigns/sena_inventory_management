import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class DialogOverlay extends ConsumerStatefulWidget {
  const DialogOverlay({super.key, required this.child, this.alpha = 1.0});

  final Widget child;
  final double alpha;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DialogOverlayState();
}

class DialogOverlayState extends ConsumerState<DialogOverlay> {
  final _widgetStack = <Widget>[];
  final _keyStack = <GlobalKey<_OverlayState>>[];
  Completer _completer = Completer();

  @override
  void initState() {
    super.initState();
    ServicesBinding.instance.keyboard.addHandler(_onKeyEvent);
  }

  @override
  void dispose() {
    ServicesBinding.instance.keyboard.removeHandler(_onKeyEvent);
    super.dispose();
  }

  bool _onKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
      popOverlay();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) => event.buttons == 8 ? popOverlay() : null,
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          Stack(children: _widgetStack.map((e) => Builder(builder: (context) => e)).toList()),
        ],
      ),
    );
  }

  Future<T?> showOverlay<T>({
    required Widget Function(BuildContext context, Widget child, double alpha) builder,
    Widget? content,
    bool isDismissible = true,
    Duration? duration,
  }) async {
    _completer = Completer<T?>();

    final key = GlobalKey<_OverlayState>();
    //print('---------------------------');
    //print('$key created');

    _keyStack.add(key);

    _widgetStack.add(
      _Overlay(
        key: key,
        isDismissible: isDismissible,
        builder: builder,
        index: _widgetStack.length,
        duration: duration,
        onStartHide: (value) {
          //print('key removed $value : ${_keyStack.contains(value)}');
          if (_keyStack.contains(value)) {
            _keyStack.remove(value);
          }

          /*if (value.currentContext != null) {
            print('$value disposed');
            setState(() {
              _widgetStack.remove(value.currentWidget);
            });
          }*/
        },
        onEndHide: (value) {
          //print('$value disposed');
          setState(() {
            _widgetStack.remove(value.currentWidget);
          });
        },
        child: content,
      ),
    );

    setState(() {});

    return _completer.future as Future<T?>;
  }

  void popOverlay<T>([T? result]) {
    if (_keyStack.isEmpty) return;

    if (!_completer.isCompleted) _completer.complete(result);

    _keyStack.last.currentState?.hide();
    setState(() {});
  }
}

class _Overlay extends ConsumerStatefulWidget {
  const _Overlay({
    super.key,
    required this.builder,
    this.child,
    this.onEndHide,
    this.onStartHide,
    this.isDismissible = true,
    this.index = 0,
    this.duration,
  });

  //final Widget child;
  final Widget Function(BuildContext context, Widget child, double alpha) builder;
  final Widget? child;
  final void Function(GlobalKey key)? onEndHide;
  final void Function(GlobalKey key)? onStartHide;
  final bool isDismissible;
  final int index;
  final Duration? duration;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OverlayState();
}

class _OverlayState extends ConsumerState<_Overlay> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 200),
    );
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.dismissed) {
        setState(() {
          widget.onEndHide?.call(widget.key as GlobalKey<_OverlayState>);
        });
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          final curvedAnimation = Curves.easeInOutCubic.transform(animationController.value);
          return IgnorePointer(
            ignoring: animationController.status == AnimationStatus.reverse,
            child: Opacity(
              opacity: 1.0,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: widget.isDismissible ? () => hide.call() : null,
                    child: NoisyBackdrop(alpha: curvedAnimation),
                  ),
                  widget.builder(context, child ?? const SizedBox(), curvedAnimation),
                ],
              ),
            ),
          );
        },
        child: widget.child);
  }

  void hide() {
    setState(() {
      animationController.reverse();
      widget.onStartHide?.call(widget.key as GlobalKey<_OverlayState>);
    });
  }
}
