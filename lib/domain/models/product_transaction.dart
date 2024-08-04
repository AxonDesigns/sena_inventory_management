import 'package:sena_inventory_management/domain/models/models.dart';

class ProductTransaction {
  ProductTransaction({
    required this.product,
    required this.amount,
  });

  factory ProductTransaction.fromJson(Map<String, dynamic> json) {
    return ProductTransaction(
      product: Product.fromJson(json['expand']["product"]),
      amount: double.parse(json["amount"].toString()),
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
