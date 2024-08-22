import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/repositories/repository.dart';

class UserRepository extends Repository<User> {
  UserRepository({required this.pocketbase});

  final PocketBase pocketbase;

  Future<List<User>> getAll() async {
    final records = await pocketbase.collection("users").getFullList(expand: 'role', sort: "+fullname");
    final token = await pocketbase.files.getToken();

    return records.map((record) {
      final avatar = pocketbase.getFileUrl(record, record.getStringValue("avatar"), token: token).toString();
      return User.fromRecord(record, avatarPath: avatar);
    }).toList();
  }

  Future<List<User>> getAllEmployees() async {
    final records = await pocketbase.collection("users").getFullList(expand: 'role', filter: 'role.privilege = 1', sort: "+fullname");
    final token = await pocketbase.files.getToken();

    return records.map((record) {
      final avatar = pocketbase.getFileUrl(record, record.getStringValue("avatar"), token: token).toString();
      return User.fromRecord(record, avatarPath: avatar);
    }).toList();
  }

  Future<User> getById(String id) async {
    final record = await pocketbase.collection("users").getOne(id, expand: 'role');
    final token = await pocketbase.files.getToken();
    final avatar = pocketbase.getFileUrl(record, record.getStringValue("avatar"), token: token).toString();
    return User.fromRecord(record, avatarPath: avatar);
  }
}
