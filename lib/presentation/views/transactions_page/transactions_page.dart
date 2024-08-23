import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/transaction_card.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionRepositoryProvider).getAll();

    return transactions.buildWidget(
      data: (data) {
        return Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Transactions', style: context.theme.textTheme.titleSmall),
                      const Spacer(),
                      Button.outline(
                        onPressed: () {
                          setState(() {
                            ref.invalidate(transactionRepositoryProvider);
                          });
                        },
                        tooltip: 'Refresh',
                        children: const [Icon(FluentIcons.arrow_sync_12_regular)],
                      ),
                      const SizedBox(width: 10),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_up_12_regular), Text('Export')]),
                      const SizedBox(width: 10),
                      Button.outline(onPressed: () {}, children: const [Icon(FluentIcons.arrow_down_12_regular), Text('Import')]),
                      const SizedBox(width: 10),
                      Button.primary(onPressed: () {}, children: const [Icon(FluentIcons.add_12_regular), Text('New')]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final transaction = data[index];
                    return TransactionCard(transaction: transaction);
                  },
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        return const Center(child: Text("Error"));
      },
    );
  }
}
