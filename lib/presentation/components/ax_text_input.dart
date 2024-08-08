import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/components/components.dart';

class AxTextInput extends ConsumerStatefulWidget {
  const AxTextInput({
    super.key,
    this.controller,
    required this.labelText,
    this.icon,
    this.focusNode,
    this.obscureText = false,
    this.required = false,
    this.inputFormatters,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.showToggleObscureButton = false,
  });

  final TextEditingController? controller;
  final String labelText;
  final FocusNode? focusNode;
  final String? errorText;
  final bool obscureText;
  final bool required;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final bool showToggleObscureButton;
  final IconData? icon;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AxTextInputState();
}

class _AxTextInputState extends ConsumerState<AxTextInput> {
  late final _focusNode = widget.focusNode ?? FocusNode();
  late final _controller = widget.controller ?? TextEditingController();
  String _errorText = '';
  var hovered = false;
  var unObscured = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocus);
    _errorText = widget.errorText ?? _errorText;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocus);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AxTextInput oldWidget) {
    setState(() {
      _errorText = widget.errorText ?? _errorText;
    });

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 100);
    const curve = Curves.fastEaseInToSlowEaseOut;
    return GestureDetector(
      onTapDown: (details) => _focusNode.requestFocus(),
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        onEnter: (event) => setState(() => hovered = true),
        onExit: (event) => setState(() => hovered = false),
        child: AnimatedContainer(
          duration: duration,
          curve: curve,
          decoration: BoxDecoration(
            color: Color.lerp(
              _focusNode.hasFocus
                  ? context.colorScheme.onSurface.withOpacity(0.1)
                  : hovered
                      ? context.colorScheme.onSurface.withOpacity(0.07)
                      : context.colorScheme.onSurface.withOpacity(0.05),
              Colors.red,
              widget.errorText != null ? 0.05 : 0.0,
            ),
            border: Border.all(
              color: widget.errorText != null ? Colors.red.withOpacity(0.4) : Colors.transparent,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon != null)
                        AnimatedOpacity(
                          duration: duration,
                          curve: curve,
                          opacity: _focusNode.hasFocus || widget.errorText != null ? 1.0 : 0.5,
                          child: Icon(
                            widget.icon!,
                            color: widget.errorText != null ? Colors.red : context.colorScheme.onSurface,
                          ),
                        ),
                      const SizedBox(width: 4.0),
                      AnimatedOpacity(
                        duration: duration,
                        curve: curve,
                        opacity: _focusNode.hasFocus || widget.errorText != null ? 1.0 : 0.5,
                        child: Text(
                          widget.labelText,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            fontSize: 11.0,
                            color: widget.errorText != null ? Colors.red : context.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      if (widget.required)
                        Text(
                          '*',
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            fontSize: 11.0,
                            color: widget.errorText != null ? context.colorScheme.onSurface : Colors.red,
                          ),
                        ),
                      const Spacer(),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        curve: curve,
                        opacity: widget.errorText != null ? 1.0 : 0.0,
                        child: Text(
                          _errorText,
                          style: context.theme.textTheme.labelMedium!.copyWith(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                color: Colors.red.withOpacity(0.5),
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 2.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        obscureText: widget.obscureText && !unObscured,
                        obscuringCharacter: '•',
                        style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 12),
                        inputFormatters: widget.inputFormatters,
                        autofocus: widget.autofocus,
                        enabled: widget.enabled,
                        readOnly: widget.readOnly,
                        onChanged: widget.onChanged,
                        onSubmitted: widget.onSubmitted,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                          filled: false,
                        ),
                      ),
                    ),
                    if (widget.showToggleObscureButton)
                      Button.ghost(
                        onPressed: () {
                          setState(() {
                            unObscured = !unObscured;
                          });
                          _focusNode.requestFocus();
                        },
                        children: [
                          Icon(
                            unObscured ? Icons.visibility_off : Icons.visibility,
                            color: widget.errorText != null ? Colors.red : context.colorScheme.onSurface.withOpacity(_focusNode.hasFocus ? 1.0 : 0.5),
                          ),
                        ],
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleFocus() {
    setState(() {});
  }
}

class AxTextInputForm extends FormField<String> {
  AxTextInputForm({
    super.key,
    this.controller,
    required this.labelText,
    this.icon,
    this.focusNode,
    this.obscureText = false,
    this.required = false,
    this.inputFormatters,
    this.autofocus = false,
    this.enabled = true,
    this.readOnly = false,
    this.showToggleObscureButton = false,
    this.onChanged,
    this.onSubmitted,
    super.onSaved,
    super.validator,
    super.autovalidateMode,
  }) : super(
          builder: (field) {
            void onChangedHandler(String value) {
              field.didChange(value);
              onChanged?.call(value);
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: AxTextInput(
                controller: controller,
                labelText: labelText,
                icon: icon,
                focusNode: focusNode,
                obscureText: obscureText,
                required: required,
                inputFormatters: inputFormatters,
                autofocus: autofocus,
                enabled: enabled,
                readOnly: readOnly,
                errorText: field.errorText,
                onChanged: onChangedHandler,
                onSubmitted: onSubmitted,
                showToggleObscureButton: showToggleObscureButton,
              ),
            );
          },
        );

  final TextEditingController? controller;
  final String labelText;
  final IconData? icon;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool required;
  final bool autofocus;
  final bool enabled;
  final bool readOnly;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool showToggleObscureButton;

  @override
  FormFieldState<String> createState() => _AxTextInputFormState();
}

class _AxTextInputFormState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  AxTextInputForm get textInput => super.widget as AxTextInputForm;
  late final _effectiveController = textInput.controller ?? _controller!.value;

  @override
  void initState() {
    super.initState();
    textInput.controller?.addListener(_handleControllerChanged);
    if (textInput.controller == null) {
      _createLocalController(widget.initialValue != null ? TextEditingValue(text: widget.initialValue!) : null);
    } else {
      textInput.controller!.addListener(_handleControllerChanged);
    }
  }

  void _createLocalController([TextEditingValue? value]) {
    _controller = value == null ? RestorableTextEditingController() : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void dispose() {
    textInput.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
    textInput.onChanged?.call(_effectiveController.text);
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
