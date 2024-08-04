import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/presentation/providers/providers.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<TransactionsPage> {
  @override
  void initState() {
    super.initState();
    onInit();
  }

  Future<void> onInit() async {
    final transactions = await ref.read(transactionRepositoryProvider).getAll();

    for (final transaction in transactions) {
      print(transaction.productTransactions.length);
      print(transaction.productTransactions.map((e) => "${e.product.name} : ${e.amount}").toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Transactions"));
  }
}
