import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';

class ProductTransactionTile extends ConsumerStatefulWidget {
  const ProductTransactionTile({super.key, required this.productTransaction});

  final ProductTransaction productTransaction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductTransactionTileState();
}

class _ProductTransactionTileState extends ConsumerState<ProductTransactionTile> {
  @override
  Widget build(BuildContext context) {
    final product = widget.productTransaction.product;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
      child: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: product.urls.isNotEmpty ? NetworkImage(product.urls.first.toString()) : null,
                child: product.urls.isEmpty ? const Icon(FluentIcons.image_16_filled) : null,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.name} (${product.unitReference.toInt()} ${product.unit.symbol}) '
                    'x ${widget.productTransaction.amount.toInt()} ',
                    style: context.theme.textTheme.bodyLarge,
                  ),
                  Text(
                    currencyFormatter.formatDouble(product.price),
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (widget.productTransaction.expirationDate != null)
                    Text(
                      'Expires: ${formatDate(widget.productTransaction.expirationDate!, withTime: false)}',
                      style: context.theme.textTheme.bodyMedium!.copyWith(
                        color: widget.productTransaction.expirationDate!.isBefore(DateTime.now())
                            ? context.colorScheme.error
                            : context.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  Text(
                    currencyFormatter.formatDouble(product.price * widget.productTransaction.amount),
                    style: context.theme.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
