import 'package:field_validators/field_validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

class ProductCreation extends ConsumerStatefulWidget {
  const ProductCreation({
    super.key,
    this.product,
  });

  final Product? product;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductCreationState();
}

class _ProductCreationState extends ConsumerState<ProductCreation> {
  final _formKey = GlobalKey<AxFormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitReferenceController = TextEditingController();
  final _createdController = TextEditingController();
  final _updatedController = TextEditingController();
  final _images = <String>[];
  final _units = <Unit>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final unitProvider = ref.read(UnitProvider);
    final units = await unitProvider.getAll();
    _units.addAll(units);

    _priceController.text = currencyFormatter.formatDouble(0.0);
    _unitReferenceController.text = 1.0.toString();

    if (widget.product != null) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description;
      _priceController.text = currencyFormatter.formatDouble(widget.product!.price);
      _unitReferenceController.text = widget.product!.unitReference.toString();
      _createdController.text = formatDate(widget.product!.created);
      _updatedController.text = formatDate(widget.product!.updated);
      _images.addAll(widget.product!.urls.map((e) => e.toString()));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: context.screenSize.width > 450 ? 450 : context.screenSize.width,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(widget.product == null ? 'New Product' : 'Edit Product', style: context.theme.textTheme.titleSmall),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: AxForm(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AxFormField(
                            name: 'name',
                            initialValue: _nameController.text,
                            validator: FieldValidators.required(),
                            builder: (field) {
                              return AxTextInput(
                                controller: _nameController,
                                errorText: field.error,
                                labelText: 'Name',
                                required: true,
                                autofocus: true,
                                onChanged: (value) {
                                  field.didChange(value);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          AxFormField<List<String>>(
                            name: 'images',
                            initialValue: _images,
                            builder: (field) {
                              return AxFilePicker(
                                labelText: 'Images',
                                fileType: FileType.image,
                                files: field.value ?? [],
                                multiSelect: true,
                                onChanged: (value) {
                                  field.didChange(value);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          AxFormField(
                            name: 'description',
                            initialValue: _descriptionController.text,
                            builder: (field) {
                              return AxTextInput(
                                controller: _descriptionController,
                                errorText: field.error,
                                labelText: 'Description',
                                onChanged: (value) {
                                  field.didChange(value);
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          AxFormField(
                            name: 'price',
                            initialValue: getUnformattedCurrency(_priceController.text),
                            validator: FieldValidators.compose([
                              FieldValidators.required(),
                              notZero(),
                              notNegative(),
                            ]),
                            builder: (field) {
                              return AxTextInput(
                                controller: _priceController,
                                errorText: field.error,
                                labelText: 'Price',
                                inputFormatters: [currencyFormatter],
                                keyboardType: TextInputType.number,
                                required: true,
                                onChanged: (value) {
                                  field.didChange(getUnformattedCurrency(value));
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 14),
                          if (_units.isNotEmpty)
                            DropdownField(
                              name: 'unit',
                              initialValue: widget.product?.unit.id,
                              labelText: 'Unit',
                              required: true,
                              items: {for (final unit in _units) unit.id: '${unit.name} (${unit.symbol})'},
                            ),
                          const SizedBox(height: 14),
                          AxFormField(
                            name: 'unit_reference',
                            initialValue: _unitReferenceController.text,
                            validator: FieldValidators.required(),
                            builder: (field) {
                              return AxTextInput(
                                controller: _unitReferenceController,
                                errorText: field.error,
                                labelText: 'Unit Reference',
                                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
                                keyboardType: TextInputType.number,
                                required: true,
                                onChanged: (value) {
                                  field.didChange(value);
                                },
                              );
                            },
                          ),
                          if (widget.product != null) ...[
                            const SizedBox(height: 14),
                            AxTextInput(
                              controller: _createdController,
                              labelText: 'Created',
                              readOnly: true,
                            ),
                            const SizedBox(height: 14),
                            AxTextInput(
                              controller: _updatedController,
                              labelText: 'Updated',
                              readOnly: true,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Button.outline(
                      onPressed: () {
                        context.popOverlay();
                      },
                      children: const [Text('Cancel')],
                    ),
                    const SizedBox(width: 10),
                    Button.primary(
                      onPressed: () {
                        if (_formKey.currentState == null) return;
                        if (_formKey.currentState!.validate()) {
                          final data = _formKey.currentState!.save();
                          final images = data['images'] as List<String>;
                          print(images);
                          context.popOverlay();
                        }
                      },
                      children: const [Text('Create')],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DropdownField<T> extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.name,
    this.initialValue,
    required this.labelText,
    required this.items,
    this.required = false,
    this.onChanged,
    this.focusNode,
  });

  final String name;
  final String labelText;
  final T? initialValue;
  final Map<T, String> items;
  final bool required;
  final void Function(T? value)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final effectiveFocusNode = focusNode ?? FocusNode();

    return AxFormField<T>(
      name: name,
      initialValue: initialValue ?? items.entries.first.key,
      builder: (field) {
        return FieldContainer(
          focusNode: effectiveFocusNode,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(labelText, style: context.theme.textTheme.bodyMedium!.copyWith(color: context.theme.colorScheme.onSurface.withOpacity(0.5))),
                    const SizedBox(width: 4),
                    if (required)
                      Text(
                        '*',
                        style: context.theme.textTheme.bodyMedium!.copyWith(
                          color: Colors.red,
                        ),
                      ),
                  ],
                ),
              ),
              DropdownButton(
                underline: const SizedBox(),
                isDense: true,
                isExpanded: true,
                style: context.theme.textTheme.bodyMedium,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                focusNode: effectiveFocusNode,
                items: items.entries
                    .map((entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ))
                    .toList(),
                value: field.value,
                onChanged: (value) {
                  field.didChange(value);
                  onChanged?.call(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
