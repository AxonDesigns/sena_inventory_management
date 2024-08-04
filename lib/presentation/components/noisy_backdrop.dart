import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class NoisyBackdrop extends ConsumerWidget {
  const NoisyBackdrop({super.key, required this.alpha});

  final double alpha;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeModeProvider).isDarkMode;

    return Stack(
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: alpha.clamp(0.0, 1.0),
            child: Container(
              color: isDarkMode ? Colors.black.withOpacity(0.25) : Colors.white.withOpacity(0.25),
            ),
          ),
        ),
        Positioned.fill(
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: alpha * 5, sigmaY: alpha * 5),
              child: Opacity(
                opacity: alpha,
                child: Image.asset(
                  "assets/images/alpha_noise_bg.png",
                  color: context.colorScheme.surface.withOpacity(0.25),
                  colorBlendMode: BlendMode.modulate,
                  fit: BoxFit.none,
                  repeat: ImageRepeat.repeat,
                  isAntiAlias: true,
                  height: 1024,
                  width: 1024,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
