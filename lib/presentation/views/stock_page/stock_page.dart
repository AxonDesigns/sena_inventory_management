import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockPage extends ConsumerStatefulWidget {
  const StockPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StockPageState();
}

class _StockPageState extends ConsumerState<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Stock"));
  }
}
