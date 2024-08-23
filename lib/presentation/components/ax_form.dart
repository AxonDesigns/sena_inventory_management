import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AxForm extends ConsumerStatefulWidget {
  const AxForm({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AxFormState();
}

class AxFormState extends ConsumerState<AxForm> {
  final List<AxFormFieldState> _fields = [];

  @override
  void didUpdateWidget(covariant AxForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Wait for the next frame to check if there are unmounted fields, if so, remove them from the list.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final unmountedFields = [];
      for (var field in _fields) {
        if (!field.mounted) {
          unmountedFields.add(field);
        }
      }

      for (var field in unmountedFields) {
        _fields.remove(field);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _addField(AxFormFieldState field) {
    _fields.add(field);
  }

  bool validate() {
    var isValid = true;
    for (var field in _fields) {
      if (!field.validate()) {
        isValid = false;
      }
    }

    setState(() {});
    return isValid;
  }

  Map<String, dynamic> save() {
    final map = <String, dynamic>{};
    for (var field in _fields) {
      map[field.widget.name] = field.value;
      field._saved();
    }
    return map;
  }
}

class AxFormField<T> extends ConsumerStatefulWidget {
  const AxFormField({
    super.key,
    required this.name,
    this.initialValue,
    required this.builder,
    this.validator,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.onSaved,
  });

  final String name;
  final T? initialValue;
  final Widget Function(AxFormFieldState<T> field) builder;
  final String? Function(T? value)? validator;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final void Function(T? value)? onSaved;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AxFormFieldState<T>();
}

class AxFormFieldState<T> extends ConsumerState<AxFormField<T>> {
  late var _value = widget.initialValue;
  String? _error;

  T? get value => _value;
  String? get error => _error;

  @override
  void initState() {
    super.initState();
    var formBuilderState = context.findAncestorStateOfType<AxFormState>();
    formBuilderState?._addField(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }

  void didChange(T? value) {
    _value = value;

    if (widget.autovalidateMode != AutovalidateMode.disabled) {
      validate();
    } else {
      setState(() {});
    }
  }

  bool validate() {
    _error = widget.validator?.call(_value);

    setState(() {});
    return _error == null;
  }

  void reset() {
    _value = widget.initialValue;
    _error = null;
    setState(() {});
  }

  void _saved() {
    widget.onSaved?.call(_value);
  }
}

/*class AxFormFieldAdapter<T> extends ConsumerStatefulWidget {
  const AxFormFieldAdapter({
    super.key,
    required this.vanillaField,
  });

  final FormField vanillaField;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AxFormFieldAdapterState<T>();
}

class AxFormFieldAdapterState<T> extends ConsumerState<AxFormFieldAdapter<T>> {
  @override
  void initState() {
    super.initState();
    //widget.vanillaField.
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/
