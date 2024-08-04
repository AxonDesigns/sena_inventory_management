import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);

  Future<T?> showOverlay<T>({
    required Widget Function(BuildContext context, Widget content, double alpha) builder,
    Widget? child,
    Duration? duration,
    bool isDismissible = true,
  }) async {
    final overlay = findAncestorStateOfType<DialogOverlayState>();
    if (overlay != null) {
      return await overlay.showOverlay<T>(
        builder: builder,
        isDismissible: isDismissible,
        content: child,
        duration: duration,
      );
    }

    return null;
  }

  void popOverlay<T extends Object?>([T? result]) {
    final overlay = findAncestorStateOfType<DialogOverlayState>();
    if (overlay != null) {
      overlay.popOverlay<T>(result);
    }
  }

  Future<T?> showLoadingOverlay<T>(Future<T?> future) async {
    showOverlay<T>(
      isDismissible: false,
      builder: (context, content, alpha) {
        return Opacity(
          opacity: alpha,
          child: Center(
            child: LoopAnimationBuilder(
              duration: const Duration(milliseconds: 1200),
              tween: Tween(begin: 0.0, end: pi * 2),
              builder: (context, child, alpha) {
                return Transform.rotate(
                  angle: alpha,
                  child: child,
                );
              },
              child: content,
            ),
          ),
        );
      },
      child: Image(
        image: const AssetImage("assets/images/loading_spinner.png"),
        color: colorScheme.primary,
        height: 16,
        width: 16,
      ),
    );

    final result = await future;
    await Future.delayed(const Duration(milliseconds: 100));
    popOverlay(result);

    return result;
  }
}
