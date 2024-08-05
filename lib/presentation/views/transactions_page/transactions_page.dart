import 'package:async_widget_builder/async_widget_builder.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/providers/providers.dart';

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
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final transaction = data[index];
            return ListTile(
              title: Text(transaction.type),
              subtitle: Text(transaction.responsible.fullName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(transaction.source.name),
                  const SizedBox(width: 10),
                  const Icon(FluentIcons.arrow_right_24_regular),
                  const SizedBox(width: 10),
                  Text(transaction.destination.name),
                ],
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        print(error);
        print(stack);
        return const Center(child: Text("Error"));
      },
    );
  }
}
