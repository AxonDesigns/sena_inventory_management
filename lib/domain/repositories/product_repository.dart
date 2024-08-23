import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class ProductRepository {
  ProductRepository({
    required this.pocketBase,
  });

  final PocketBase pocketBase;

  Future<List<Product>> getAll() async {
    final records = await pocketBase.collection('products').getFullList(expand: 'type,state,unit,categories', sort: 'updated');
    final token = await pocketBase.files.getToken();

    final products = Future.wait(records.map((record) async {
      final imageNames = record.getListValue('images', <String>[]);
      final urls = imageNames.map((imageName) => pocketBase.getFileUrl(record, imageName, token: token, thumb: '30x30')).toList();
      final product = Product.fromRecord(record);
      print(urls
          .map(
            (e) => e.authority,
          )
          .toList());
      product.urls = urls;
      return product;
    }).toList());
    return products;
  }

  Future<Product> getById(String id) async {
    final token = await pocketBase.files.getToken();

    final record = await pocketBase.collection('products').getOne(id, expand: 'type,state,unit,categories');
    final imageNames = record.getListValue('images', <String>[]);
    final urls = imageNames.map((imageName) => pocketBase.getFileUrl(record, imageName, token: token, thumb: '30x30')).toList();
    final product = Product.fromRecord(record);
    product.urls = urls;
    return product;
  }
}
