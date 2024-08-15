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
                  AxTextInputForm(labelText: 'Unit', required: true),
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
