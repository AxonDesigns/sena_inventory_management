import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class AxPicker extends ConsumerStatefulWidget {
  const AxPicker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AxPickerState();
}

class _AxPickerState extends ConsumerState<AxPicker> {
  @override
  Widget build(BuildContext context) {
    return FieldContainer(
      enablePressedState: true,
      onTap: () {
        _handleTap();
      },
      child: const Padding(
        padding: EdgeInsets.all(14.0),
        child: Text("AX Picker"),
      ),
    );
  }

  void _handleTap() async {
    final result = await context.showOverlay<String>(
      builder: (context, content, alpha) {
        return Opacity(opacity: alpha, child: content);
      },
      child: const _PickerOverlay(),
    );

    if (result != null) {
      print(result);
    }
  }
}

class _PickerOverlay extends ConsumerStatefulWidget {
  const _PickerOverlay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickerOverlayState();
}

class _PickerOverlayState extends ConsumerState<_PickerOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Overlay"),
    );
  }
}
