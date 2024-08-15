import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';
import 'package:sena_inventory_management/presentation/providers/providers.dart';
import 'package:sena_inventory_management/presentation/views/transactions_page/transaction_card.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<TransactionsPage> {
  late final _transactions = ref.read(transactionRepositoryProvider).getAll();

  @override
  Widget build(BuildContext context) {
    return _transactions.buildWidget(
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

  Widget _buildTransactionTile(BuildContext context, Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: GestureDetector(
        onTap: () => print(transaction.id),
        child: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${transaction.type} - ${formatDate(transaction.updated)}',
                        style: context.theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(transaction.responsable.fullName, style: context.theme.textTheme.bodyMedium),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(transaction.source.name, style: context.theme.textTheme.bodyMedium),
                          const SizedBox(width: 10),
                          const Icon(FluentIcons.chevron_right_12_regular),
                          const SizedBox(width: 10),
                          Text(transaction.destination.name, style: context.theme.textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${transaction.productTransactions.fold(0.0, (previousValue, element) => previousValue + element.amount)} products',
                  style: context.theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Icon(FluentIcons.chevron_right_12_regular),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
