import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class ProductRepository {
  ProductRepository({
    required this.pocketBase,
  });

  final PocketBase pocketBase;

  Future<List<Product>> getAll() async {
    final records = await pocketBase.collection('products').getFullList(expand: 'type,state,unit');
    final products = records.map((record) => Product.fromJson(record.toJson())).toList();
    return products;
  }
}
