import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/providers/providers.dart';

class Button extends ConsumerStatefulWidget {
  const Button.custom({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.useOutline = false,
    this.animateOpacity = false,
    this.canInteract = true,
    required this.backgroundColor,
    required this.foregroundColor,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  }) : type = null;

  const Button.primary({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.canInteract = true,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  })  : type = AxType.primary,
        backgroundColor = null,
        foregroundColor = null,
        useOutline = false,
        animateOpacity = false;

  const Button.secondary({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.canInteract = true,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  })  : type = AxType.secondary,
        backgroundColor = null,
        foregroundColor = null,
        useOutline = false,
        animateOpacity = false;

  const Button.outline({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.canInteract = true,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  })  : type = AxType.outline,
        backgroundColor = null,
        foregroundColor = null,
        useOutline = true,
        animateOpacity = true;

  const Button.ghost({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.canInteract = true,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  })  : type = AxType.ghost,
        backgroundColor = null,
        foregroundColor = null,
        useOutline = false,
        animateOpacity = true;

  const Button.glass({
    super.key,
    this.children = const [],
    this.builder,
    required this.onPressed,
    this.canInteract = true,
    this.gap = 5.0,
    this.tooltip,
    this.canBeFocused = true,
    this.focusNode,
  })  : type = AxType.glass,
        backgroundColor = null,
        foregroundColor = null,
        useOutline = true,
        animateOpacity = true;

  final List<Widget> children;
  final Widget Function(bool hovered, bool pressed, bool focused)? builder;
  final AxType? type;
  final String? tooltip;
  final bool useOutline;
  final bool animateOpacity;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool canInteract;
  final double gap;
  final bool canBeFocused;
  final FocusNode? focusNode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AxButtonState();
}

class _AxButtonState extends ConsumerState<Button> {
  var hovered = false;
  var pressed = false;
  late final _focusNode = widget.focusNode ?? FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tooltip != null
        ? Tooltip(
            message: widget.tooltip,
            child: _buildButton(context, ref),
          )
        : _buildButton(context, ref);
  }

  Widget _buildButton(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider).isDarkMode;

    bool isDisabled = widget.onPressed == null;
    Color targetBGColor = widget.type == null
        ? widget.backgroundColor!
        : switch (widget.type) {
            AxType.primary => context.colorScheme.primary,
            AxType.secondary => context.colorScheme.secondary,
            AxType.outline || AxType.ghost => context.colorScheme.onSurface.withOpacity(0.0),
            AxType.glass => context.colorScheme.primary.withOpacity(0.1),
            _ => Colors.transparent,
          };

    Color targetFGColor = widget.type == null
        ? widget.foregroundColor!
        : switch (widget.type) {
            AxType.primary => context.colorScheme.onPrimary,
            AxType.secondary => context.colorScheme.onSecondary,
            AxType.outline || AxType.ghost => context.colorScheme.onSurface,
            AxType.glass => context.colorScheme.primary,
            _ => targetBGColor.withOpacity(0.0),
          };

    final bgColorHovered = widget.type == null
        ? widget.animateOpacity
            ? targetBGColor.withOpacity(targetBGColor.opacity * 1.75)
            : targetBGColor.toHSLColor.withRelativeLightness(-0.1).withRelativeSaturation(0.1).toColor()
        : switch (widget.type) {
            AxType.primary =>
              targetBGColor.toHSLColor.withRelativeLightness(isDarkMode ? -0.1 : -0.05).withRelativeSaturation(isDarkMode ? -0.1 : -0.1).toColor(),
            AxType.secondary =>
              targetBGColor.toHSLColor.withRelativeLightness(isDarkMode ? -0.1 : -0.05).withRelativeSaturation(isDarkMode ? 0.1 : 0.1).toColor(),
            AxType.outline || AxType.ghost => targetBGColor.withOpacity(0.1),
            AxType.glass => targetBGColor.withOpacity(0.2),
            _ => targetBGColor.withOpacity(0.0),
          };
    final bgColorPressed = widget.type == null
        ? widget.animateOpacity
            ? targetBGColor.withOpacity(targetBGColor.opacity * 0.6)
            : targetBGColor.toHSLColor.withRelativeLightness(-0.15).withRelativeSaturation(-0.1).toColor()
        : switch (widget.type!) {
            AxType.primary =>
              targetBGColor.toHSLColor.withRelativeLightness(isDarkMode ? -0.2 : -0.1).withRelativeSaturation(isDarkMode ? -0.2 : -0.2).toColor(),
            AxType.secondary =>
              targetBGColor.toHSLColor.withRelativeLightness(isDarkMode ? -0.25 : -0.125).withRelativeSaturation(isDarkMode ? 0.15 : 0.15).toColor(),
            AxType.outline || AxType.ghost => targetBGColor.withOpacity(isDarkMode ? 0.05 : 0.2),
            AxType.glass => targetBGColor.withOpacity(isDarkMode ? 0.1 : 0.3),
          };

    final bgColorDisabled = targetBGColor;

    final borderColorInactive = widget.type == null
        ? widget.animateOpacity
            ? targetFGColor.withOpacity(targetFGColor.opacity * 0.25)
            : targetFGColor.withOpacity(0.0)
        : switch (widget.type) {
            AxType.outline => targetBGColor.withOpacity(0.2),
            AxType.glass => targetBGColor.withOpacity(0.3),
            _ => targetBGColor.withOpacity(0.0),
          };

    final borderColorHovered = widget.type == null
        ? widget.animateOpacity
            ? targetFGColor.withOpacity(targetFGColor.opacity * 0.5)
            : targetFGColor.withOpacity(0.0)
        : switch (widget.type) {
            AxType.outline => context.colorScheme.onSurface.withOpacity(0.1),
            AxType.glass => targetBGColor.withOpacity(0.2),
            _ => targetBGColor.withOpacity(0.0),
          };

    final borderColorPressed = widget.type == null
        ? widget.animateOpacity
            ? targetFGColor.withOpacity(targetFGColor.opacity * 0.15)
            : targetFGColor.withOpacity(0.0)
        : switch (widget.type) {
            AxType.outline => context.colorScheme.onSurface.withOpacity(0.1),
            AxType.glass => targetBGColor.withOpacity(0.2),
            _ => targetBGColor.withOpacity(0.0),
          };
    return FocusableActionDetector(
      focusNode: _focusNode,
      //enabled: widget.canBeFocused,
      onShowHoverHighlight: (value) => setState(
        () => hovered = value,
      ),
      mouseCursor: isDisabled ? SystemMouseCursors.forbidden : SystemMouseCursors.basic,
      child: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTapDown: (details) => setState(() => pressed = true),
        onTapUp: (details) => setState(() => pressed = false),
        onTapCancel: () => setState(() => pressed = false),
        onTap: widget.onPressed == null
            ? null
            : () {
                if (widget.canInteract) widget.onPressed!.call();
              },
        child: Opacity(
          opacity: isDisabled ? 0.65 : 1.0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: pressed ? 50 : 200),
            curve: Curves.fastEaseInToSlowEaseOut,
            decoration: BoxDecoration(
              color: !widget.canInteract
                  ? targetBGColor
                  : isDisabled
                      ? bgColorDisabled
                      : pressed
                          ? bgColorPressed
                          : hovered
                              ? bgColorHovered
                              : targetBGColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                strokeAlign: BorderSide.strokeAlignInside,
                width: 1.0,
                color: !widget.canInteract
                    ? borderColorInactive
                    : isDisabled
                        ? targetBGColor.withOpacity(0.0)
                        : pressed
                            ? borderColorPressed
                            : hovered
                                ? borderColorHovered
                                : borderColorInactive,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                /* horizontal: widget.squared ? 7.5 : 12.0,
                vertical: widget.squared ? 7.5 : 6.0, */
                horizontal: widget.children.length == 1 && widget.children.first is! Text ? 7.5 : 12.0,
                vertical: widget.children.length == 1 && widget.children.first is! Text ? 7.5 : 6.0,
              ),
              child: IconTheme(
                data: IconThemeData(
                  color: targetFGColor,
                  size: 16,
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: targetFGColor,
                    fontWeight: FontWeight.w400,
                  ),
                  child: widget.builder?.call(hovered, pressed, false) ??
                      (widget.children.isNotEmpty
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate((widget.children.length * 2) - 1,
                                  (index) => index.isEven ? widget.children[index ~/ 2] : SizedBox(width: widget.gap)),
                            )
                          : const SizedBox.shrink()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum AxType {
  primary,
  secondary,
  outline,
  ghost,
  glass,
}
