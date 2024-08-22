import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';

class TransactionRepository {
  TransactionRepository({
    required this.pocketBase,
    required this.userRepository,
    required this.productRepository,
  });

  final PocketBase pocketBase;
  final UserRepository userRepository;
  final ProductRepository productRepository;

  static const _expand =
      'responsable,responsable.role,source,destination,source.city,source.city.department,source.type,destination.city,destination.city.department,destination.type';

  Future<List<Transaction>> getAll() async {
    final records = await pocketBase.collection('transactions').getFullList(expand: _expand);
    final transactions = await Future.wait(records.map((record) async {
      final productTransactions = await getProductsForTransaction(record.id);
      final responsable = await userRepository.getById(record.expand['responsable']!.first.id);
      return Transaction.fromRecord(record, productTransactions, responsable);
    }).toList());

    return transactions;
  }

  Future<Transaction> getById(String id) async {
    final record = await pocketBase.collection('transactions').getOne(id, expand: _expand);
    final productTransactions = await getProductsForTransaction(id);
    final responsable = await userRepository.getById(record.expand['responsable']!.first.id);
    return Transaction.fromRecord(record, productTransactions, responsable);
  }

  Future<List<ProductTransaction>> getProductsForTransaction(String id) async {
    final records = await pocketBase.collection('product_transactions').getFullList(
          expand: 'product,product.unit,product.type,product.state,product.categories',
          filter: "transaction.id = '$id'",
        );
    final productTransactions = Future.wait(records.map((record) async {
      final product = await productRepository.getById(record.getStringValue('product'));
      return ProductTransaction.fromRecord(record, product);
    }).toList());
    return productTransactions;
  }
}
