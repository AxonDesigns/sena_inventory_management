import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class ProductTransaction extends Model {
  ProductTransaction({
    required super.id,
    required this.product,
    required this.amount,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory ProductTransaction.fromRecord(RecordModel record) {
    return ProductTransaction(
      id: record.id,
      product: Product.fromRecord(record.expand["product"]!.first),
      amount: record.getDoubleValue("amount"),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  final Product product;
  final double amount;

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'ProductTransaction {product: $product, amount: $amount}';
  }
}
