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
    return const FieldContainer(
      enablePressedState: true,
      child: Padding(
        padding: EdgeInsets.all(14.0),
        child: Text("AX Picker"),
      ),
    );
  }
}
