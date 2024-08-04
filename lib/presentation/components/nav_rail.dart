import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';

class NavRail extends ConsumerStatefulWidget {
  const NavRail({
    super.key,
    required this.items,
    this.selected = 0,
    this.onItemSelected,
    this.maxWidth = 200,
    this.gap = 4.0,
    this.size = 50.0,
    this.header,
    this.footer,
  });

  final Widget Function(double minSize, double maxSize, double gap, bool isOpen)? header;
  final Widget Function(double minSize, double maxSize, double gap, bool isOpen)? footer;
  final double maxWidth;
  final List<NavRailItem> items;
  final int selected;
  final double gap;
  final double size;
  final void Function(int index)? onItemSelected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavRailState();
}

class _NavRailState extends ConsumerState<NavRail> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isOpen = true),
      onExit: (event) => setState(() => _isOpen = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut,
        width: _isOpen ? (widget.gap * 4) + widget.maxWidth : (widget.gap * 4) + widget.size,
        decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(4.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isOpen ? 0.2 : 0.0),
                blurRadius: 10.0,
                spreadRadius: 0.0,
                offset: const Offset(0.0, 0.0),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if (widget.header != null) widget.header?.call(widget.size, widget.maxWidth, widget.gap, _isOpen) ?? const SizedBox.shrink(),
            for (final item in widget.items.indexed)
              Padding(
                padding: EdgeInsets.symmetric(vertical: widget.gap, horizontal: widget.gap * 2),
                child: _NavRailItem(
                  iconSize: 16,
                  gap: widget.gap,
                  size: widget.size,
                  selected: item.$1 == widget.selected,
                  index: item.$1,
                  onPressed: (index) {
                    widget.onItemSelected?.call(index);
                  },
                  item: item.$2,
                ),
              ),
            const Spacer(),
            if (widget.footer != null) widget.footer?.call(widget.size, widget.maxWidth, widget.gap, _isOpen) ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class NavRailItem {
  const NavRailItem({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}

class _NavRailItem extends ConsumerStatefulWidget {
  const _NavRailItem({
    super.key,
    required this.item,
    required this.selected,
    required this.index,
    required this.onPressed,
    required this.size,
    required this.gap,
    required this.iconSize,
  });

  final NavRailItem item;
  final int index;
  final double iconSize;
  final double size;
  final double gap;
  final void Function(int index) onPressed;
  final bool selected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavRailItemState();
}

class _NavRailItemState extends ConsumerState<_NavRailItem> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final bgColor = widget.selected
        ? context.colorScheme.primary.withOpacity(_isHovered ? 0.85 : 1.0)
        : context.colorScheme.surfaceContainerHighest.withOpacity(_isHovered ? 1.0 : 0.5);
    return FocusableActionDetector(
      onShowHoverHighlight: (value) => setState(() => _isHovered = value),
      mouseCursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onPressed.call(widget.index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.fastEaseInToSlowEaseOut,
          height: widget.size,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: ClipRRect(
            child: OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: widget.size,
                    child: Icon(
                      widget.item.icon,
                      color: widget.selected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                      size: widget.iconSize,
                    ),
                  ),
                  Text(
                    widget.item.title,
                    style: context.theme.textTheme.labelMedium!.copyWith(
                      color: widget.selected ? context.colorScheme.onPrimary : context.colorScheme.onSurface,
                      fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavRailWidget extends ConsumerWidget {
  const NavRailWidget({
    super.key,
    required this.icon,
    required this.content,
    this.background,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.minSize,
    required this.maxSize,
    this.gap = 4.0,
    this.padding = const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
    this.height = 1.0,
  });

  final Widget icon;
  final Widget content;
  final Widget? background;
  final double minSize;
  final double maxSize;
  final double height;
  final double gap;
  final EdgeInsets padding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(gap * 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            Positioned.fill(
              child: background ?? const SizedBox(),
            ),
            SizedBox(
              height: minSize * height,
              child: OverflowBox(
                maxWidth: maxSize,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: crossAxisAlignment,
                  children: [
                    SizedBox(
                      width: minSize,
                      height: minSize,
                      child: Center(child: icon),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: minSize,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: content,
                        ),
                      ),
                    ),
                    SizedBox(width: gap),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
