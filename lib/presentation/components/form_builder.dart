import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormBuilder extends ConsumerStatefulWidget {
  const FormBuilder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FormBuilderState();
}

class FormBuilderState extends ConsumerState<FormBuilder> {
  final List<FormFieldBuilderState> _fields = [];

  @override
  void didUpdateWidget(covariant FormBuilder oldWidget) {
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

  void _addField(FormFieldBuilderState field) {
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

  Map<String, dynamic> getData() {
    final map = <String, dynamic>{};
    for (var field in _fields) {
      map[field.widget.name] = field.value;
    }
    return map;
  }
}

class FormFieldBuilder<T> extends ConsumerStatefulWidget {
  const FormFieldBuilder({
    super.key,
    required this.name,
    this.initialValue,
    required this.builder,
    this.validator,
  });

  final String name;
  final T? initialValue;
  final Widget Function(FormFieldBuilderState<T> field) builder;
  final String? Function(T? value)? validator;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => FormFieldBuilderState<T>();
}

class FormFieldBuilderState<T> extends ConsumerState<FormFieldBuilder<T>> {
  late var _value = widget.initialValue;
  String? _error;

  T? get value => _value;
  String? get error => _error;

  @override
  void initState() {
    super.initState();
    var formBuilderState = context.findAncestorStateOfType<FormBuilderState>();
    formBuilderState?._addField(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }

  void didChange(T? value) {
    setState(() {
      _value = value;
    });
  }

  bool validate() {
    if (widget.validator != null) {
      final error = widget.validator!(_value);
      if (error != null) {
        _error = error;
      } else {
        _error = null;
      }
    }

    setState(() {});
    return _error == null;
  }
}
