import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/repositories/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository({required this.pocketbase});

  final PocketBase pocketbase;

  Future<List<User>> getAll() async {
    final records = await pocketbase.collection("users").getFullList(expand: 'role', sort: "+fullname");
    return records.map((record) => User.fromRecord(record)).toList();
  }

  Future<List<User>> getAllEmployees() async {
    final records = await pocketbase.collection("users").getFullList(expand: 'role', filter: 'role.privilege = 1', sort: "+fullname");
    return records.map((record) => User.fromRecord(record)).toList();
  }
}
