import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class TransactionRepository {
  TransactionRepository({
    required this.pocketBase,
  });

  final PocketBase pocketBase;

  static const _expand =
      'responsible,source,destination,source.city,source.city.department,source.type,destination.city,destination.city.department,destination.type';

  Future<List<Transaction>> getAll() async {
    final records = await pocketBase.collection('transactions').getFullList(expand: _expand);
    final transactions = Future.wait(records.map((record) async {
      final productTransactions = await getProductsForTransaction(record.id);
      return Transaction.fromJson(record.toJson(), productTransactions);
    }).toList());

    return transactions;
  }

  Future<Transaction> getById(String id) async {
    final record = await pocketBase.collection('transactions').getOne(id, expand: _expand);
    final productTransactions = await getProductsForTransaction(id);
    return Transaction.fromJson(record.toJson(), productTransactions);
  }

  Future<List<ProductTransaction>> getProductsForTransaction(String id) async {
    final records = await pocketBase.collection('product_transactions').getFullList(
          expand: 'product,product.unit,product.type, product.state',
          filter: "transaction.id = '$id'",
        );
    final productTransactions = records.map((record) => ProductTransaction.fromJson(record.toJson())).toList();
    return productTransactions;
  }
}
