import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class TransactionRepository {
  TransactionRepository({
    required this.pocketBase,
  });

  final PocketBase pocketBase;

  static const _expand =
      'responsable,responsable.role,source,destination,source.city,source.city.department,source.type,destination.city,destination.city.department,destination.type';

  Future<List<Transaction>> getAll() async {
    final records = await pocketBase.collection('transactions').getFullList(expand: _expand);
    final transactions = await Future.wait(records.map((record) async {
      final productTransactions = await getProductsForTransaction(record.id);
      return Transaction.fromRecord(record, productTransactions);
    }).toList());

    return transactions;
  }

  Future<Transaction> getById(String id) async {
    final record = await pocketBase.collection('transactions').getOne(id, expand: _expand);
    final productTransactions = await getProductsForTransaction(id);
    return Transaction.fromRecord(record, productTransactions);
  }

  Future<List<ProductTransaction>> getProductsForTransaction(String id) async {
    final records = await pocketBase.collection('product_transactions').getFullList(
          expand: 'product,product.unit,product.type,product.state,product.categories',
          filter: "transaction.id = '$id'",
        );
    final productTransactions = records.map((record) => ProductTransaction.fromRecord(record)).toList();
    return productTransactions;
  }
}
