import 'package:sena_inventory_management/domain/models/models.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String fullName;
  final Role role;
  final String phoneNumber;
  final String citizenId;
  final String avatarFileName;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    required this.phoneNumber,
    required this.citizenId,
    required this.avatarFileName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      fullName: json['fullname'].toString(),
      role: Role.fromJson(json['expand']['role']),
      phoneNumber: json['phone_number'].toString(),
      citizenId: json['citizen_id'].toString(),
      avatarFileName: json['avatar_file_name'].toString(),
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
      'avatar_file_name': avatarFileName,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, fullName: $fullName, role: $role, phoneNumber: $phoneNumber, citizenId: $citizenId, avatarFileName: $avatarFileName)';
  }
}
