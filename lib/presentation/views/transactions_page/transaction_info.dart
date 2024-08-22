import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/product_transaction_tile.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/transaction_status_chip.dart';

class TransactionInfo extends ConsumerStatefulWidget {
  const TransactionInfo({super.key, required this.alpha, required this.transaction});

  final double alpha;
  final Transaction transaction;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TransactionInfoState();
}

class _TransactionInfoState extends ConsumerState<TransactionInfo> {
  @override
  Widget build(BuildContext context) {
    final total = currencyFormatter.formatDouble(
        widget.transaction.productTransactions.fold(0.0, (previousValue, element) => previousValue + element.amount * element.product.price));
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.transaction.type, style: context.theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 10),
                      TransactionStatusChip(status: widget.transaction.status),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Text(widget.transaction.source.name, style: context.theme.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          const Icon(FluentIcons.chevron_right_12_regular),
                          const SizedBox(width: 10),
                          Text(widget.transaction.destination.name, style: context.theme.textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.transaction.responsable.avatarPath ?? ''),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.transaction.responsable.fullName,
                              style: context.theme.textTheme.bodyMedium,
                            ),
                            Text(
                              widget.transaction.responsable.email,
                              style: context.theme.textTheme.bodyMedium!.copyWith(color: context.colorScheme.onSurface.withOpacity(0.5)),
                            ),
                          ],
                        ),
                      ])
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Text('Products', style: context.theme.textTheme.titleSmall),
                              const Spacer(),
                              Button.outline(
                                onPressed: () {},
                                children: const [Icon(FluentIcons.arrow_up_16_regular), Text('Export')],
                              ),
                              const SizedBox(width: 10),
                              Button.primary(
                                onPressed: () {
                                  context.showOverlay(
                                    builder: (context, content, alpha) {
                                      return const Center(
                                        child: Text('Add Product'),
                                      );
                                    },
                                  );
                                },
                                children: const [Icon(FluentIcons.add_16_regular), Text('Add')],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: context.colorScheme.surfaceContainerLowest,
                          ),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 14.0),
                            itemCount: widget.transaction.productTransactions.length,
                            itemBuilder: (context, index) {
                              return ProductTransactionTile(productTransaction: widget.transaction.productTransactions[index]);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total: $total',
                          style: context.theme.textTheme.bodyLarge,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Button.outline(
                            onPressed: () {
                              context.popOverlay();
                            },
                            children: const [Text('Close')],
                          ),
                          const SizedBox(width: 10),
                          Button.primary(
                            onPressed: () {
                              context.popOverlay();
                            },
                            children: const [Text('Accept')],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
