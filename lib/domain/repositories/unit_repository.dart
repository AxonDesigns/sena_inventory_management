import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/repositories/repository.dart';

class UnitRepository extends Repository<Role> {
  UnitRepository({required this.pocketbase});

  final PocketBase pocketbase;

  Future<List<Unit>> getAll() async {
    final records = await pocketbase.collection("units").getFullList(sort: "+name");
    return records.map((record) => Unit.fromRecord(record)).toList();
  }

  Future<Unit> getById(String id) async {
    final record = await pocketbase.collection("units").getOne(id);
    return Unit.fromRecord(record);
  }
}
