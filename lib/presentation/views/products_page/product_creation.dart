import 'package:flutter/material.dart';
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
  final _test = GlobalKey<FormFieldState<String>>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 450,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('New Product', style: context.theme.textTheme.titleSmall),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Name', required: true),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Image', required: true),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Description', required: true),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Price', required: true),
                  const SizedBox(height: 14),
                  DropdownField(
                    formFieldKey: _test,
                    labelText: 'Unit',
                    items: const {
                      'Kg': 'kg',
                      'Lb': 'lb',
                      'G': 'g',
                    },
                  ),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Unit Reference', required: true),
                  const Spacer(),
                  Row(
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
                        onPressed: () {},
                        children: const [Text('Create')],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DropdownField<T> extends StatelessWidget {
  const DropdownField({
    super.key,
    this.formFieldKey,
    required this.labelText,
    required this.items,
    this.onChanged,
  });

  final Key? formFieldKey;
  final String labelText;
  final Map<String, T> items;
  final void Function(T? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      key: formFieldKey,
      initialValue: items.entries.first.value,
      builder: (field) {
        return Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 14.0, top: 10.0),
                child: Text(labelText, style: context.theme.textTheme.bodyMedium),
              ),
              DropdownButton(
                underline: const SizedBox(),
                isDense: true,
                isExpanded: true,
                style: context.theme.textTheme.bodyMedium,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                items: items.entries
                    .map((entry) => DropdownMenuItem(
                          value: entry.value,
                          child: Text(entry.key),
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
