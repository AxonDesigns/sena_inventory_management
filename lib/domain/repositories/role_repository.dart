import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/repositories/repository.dart';

class RoleRepository extends Repository<Role> {
  RoleRepository({required this.pocketbase});

  final PocketBase pocketbase;

  Future<List<Role>> getAll() async {
    final records = await pocketbase.collection("roles").getFullList(sort: "+privilege");
    return records.map((record) => Role.fromJson(record.toJson())).toList();
  }
}
