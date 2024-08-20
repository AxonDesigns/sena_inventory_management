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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('New Product', style: context.theme.textTheme.titleSmall),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Name', required: true),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Description', required: true),
                  const SizedBox(height: 14),
                  AxTextInputForm(labelText: 'Price', required: true),
                  const SizedBox(height: 14),
                  FormField<String>(
                    initialValue: 'kg',
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
                              child: Text("Unit", style: context.theme.textTheme.bodyMedium),
                            ),
                            DropdownButton(
                              underline: const SizedBox(),
                              isDense: true,
                              isExpanded: true,
                              style: context.theme.textTheme.bodyMedium,
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              items: const [
                                DropdownMenuItem(
                                  value: 'kg',
                                  child: Text('Kg'),
                                ),
                                DropdownMenuItem(
                                  value: 'lb',
                                  child: Text('Lb'),
                                ),
                                DropdownMenuItem(
                                  value: 'g',
                                  child: Text('G'),
                                ),
                              ],
                              value: field.value,
                              onChanged: (value) => field.didChange(value),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
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
                        onPressed: () {
                          context.popOverlay();
                        },
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
