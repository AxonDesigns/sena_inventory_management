import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';

class Link extends ConsumerStatefulWidget {
  const Link({
    super.key,
    required this.child,
    this.onPressed,
  });

  final Widget child;
  final void Function()? onPressed;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AxLinkState();
}

class _AxLinkState extends ConsumerState<Link> {
  var hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) => setState(() => hovered = true),
        onExit: (event) => setState(() => hovered = false),
        child: DefaultTextStyle(
          style: context.theme.textTheme.bodyMedium!.copyWith(
            color: hovered ? context.colorScheme.onSurface : context.colorScheme.onSurface.withOpacity(0.75),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
