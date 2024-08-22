import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';

class FieldContainer extends ConsumerStatefulWidget {
  const FieldContainer({
    super.key,
    this.child,
    this.builder,
    this.onTap,
    this.focusNode,
    this.handlePressedState = false,
  }) : assert(child != null || builder != null);

  final Widget? child;
  final Widget Function(Set<WidgetState> states)? builder;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool handlePressedState;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FieldContainerState();
}

class _FieldContainerState extends ConsumerState<FieldContainer> {
  var hovered = false;
  var pressed = false;
  bool get focused => widget.focusNode?.hasFocus ?? false;

  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_handleFocus);
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_handleFocus);
    super.dispose();
  }

  void _handleFocus() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var state = {
      if (hovered) WidgetState.hovered,
      if (pressed && widget.handlePressedState) WidgetState.pressed,
      if (focused) WidgetState.focused,
    };

    var bgColor = WidgetStateProperty.resolveWith(
      (states) {
        var color = context.colorScheme.surfaceContainerLow;
        if (states.contains(WidgetState.hovered)) {
          color = context.colorScheme.surfaceContainerLow.toHSLColor.withRelativeLightness(0.025).withRelativeSaturation(-0.025).toColor();
        }
        if (states.contains(WidgetState.pressed)) {
          color = context.colorScheme.surfaceContainerLow.toHSLColor.withRelativeLightness(-0.025).toColor();
        }

        if (states.contains(WidgetState.focused)) {
          color = context.colorScheme.surfaceContainerLow.toHSLColor.withRelativeLightness(0.05).withRelativeSaturation(-0.03).toColor();
        }

        return color;
      },
    );

    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (event) => setState(() => pressed = true),
      onTapUp: (event) => setState(() => pressed = false),
      onTapCancel: () => setState(() => pressed = false),
      child: MouseRegion(
        onEnter: (event) => setState(() => hovered = true),
        onExit: (event) => setState(() => hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.fastEaseInToSlowEaseOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: bgColor.resolve(state),
          ),
          child: widget.builder?.call(state) ?? widget.child,
        ),
      ),
    );
  }
}
