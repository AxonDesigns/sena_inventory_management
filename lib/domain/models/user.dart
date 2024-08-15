import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class User extends Model {
  final String username;
  final String email;
  final String fullName;
  final Role role;
  final String phoneNumber;
  final String citizenId;
  final String avatar;
  final String? avatarPath;

  User({
    required super.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    required this.phoneNumber,
    required this.citizenId,
    required this.avatar,
    required super.created,
    required super.updated,
    this.avatarPath,
  }) : super(record: RecordModel());

  factory User.fromRecord(RecordModel record, {String? avatarPath}) {
    return User(
      id: record.id,
      username: record.getStringValue('username'),
      email: record.getStringValue('email'),
      fullName: record.getStringValue('fullname'),
      role: Role.fromRecord(record.expand['role']!.first),
      phoneNumber: record.getStringValue('phone_number'),
      citizenId: record.getStringValue('citizen_id'),
      avatar: record.getStringValue('avatar'),
      avatarPath: avatarPath,
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullname': fullName,
      'role': role,
      'phone_number': phoneNumber,
      'citizen_id': citizenId,
      'avatar': avatar,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, fullName: $fullName, role: $role, phoneNumber: $phoneNumber, citizenId: $citizenId, avatar: $avatar)';
  }
}
