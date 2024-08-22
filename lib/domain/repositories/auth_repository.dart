import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:sena_inventory_management/core/core.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/repositories/repository.dart';

class AuthRepository extends Repository<User> {
  AuthRepository({required this.pocketbase, required this.roleRepository});
  final RoleRepository roleRepository;
  final PocketBase pocketbase;
  User? _user;
  RecordModel? _userModel;

  bool get isAuthenticated => pocketbase.authStore.isValid;

  bool get isValidated {
    return !pocketbase.authStore.isValid ? false : pocketbase.authStore.model.data["verified"] ?? false;
  }

  late final dio = Dio(BaseOptions(baseUrl: pocketbase.baseUrl));

  Future<User?> get user async {
    if (!pocketbase.authStore.isValid) {
      _user = null;
      return _user;
    }

    final currentModel = await model;
    if (currentModel == null) return null;
    _user = User.fromRecord(currentModel);

    return _user;
  }

  Future<RecordModel?> get model async {
    if (!pocketbase.authStore.isValid) {
      return null;
    }

    try {
      _userModel ??= await pocketbase.collection("users").getOne(pocketbase.authStore.model.id, expand: 'role');
    } catch (e) {
      _userModel = null;
    }

    return _userModel;
  }

  Future<String?> get avatarPath async {
    if (!pocketbase.authStore.isValid) return null;
    final currentModel = await model;
    if (currentModel == null) return null;

    final token = await pocketbase.files.getToken();
    try {
      return pocketbase.getFileUrl(currentModel, currentModel.getStringValue("avatar"), token: token).toString();
    } catch (e) {
      return null;
    }
  }

  Future<Result<User, ClientException>> signIn({required String email, required String password}) async {
    try {
      final recordAuth = await pocketbase.collection("users").authWithPassword(email, password, expand: 'role');
      final record = recordAuth.record;
      if (record == null) return Result(error: ClientException());
      return Result(data: User.fromRecord(record));
    } on ClientException catch (e) {
      return Result(error: e);
    }
  }

  Future<Result<User, ClientException>> signUp({
    required String email,
    required String password,
    required String fullname,
    required String phoneNumber,
    required String citizenId,
    required String avatarPath,
    String role = "94cyru8torlfbzb", // unassigned
  }) async {
    RecordModel? recordModel;
    try {
      recordModel = await pocketbase.collection("users").create(body: {
        "username": null,
        "email": email,
        "emailVisibility": true,
        "password": password,
        "passwordConfirm": password,
        "fullname": fullname,
        "role": role,
        "phone_number": phoneNumber,
        "citizen_id": citizenId,
      }, files: [
        http.MultipartFile.fromBytes(
          "avatar",
          File(avatarPath).readAsBytesSync(),
          filename: avatarPath,
          contentType: MediaType("image", "jpg"),
        ),
      ]);
    } on ClientException catch (e) {
      return Result(error: e);
    }

    return Result(data: User.fromRecord(recordModel));
  }

  void signOut() {
    pocketbase.authStore.clear();
  }

  Future<Result<void, ClientException>> requestEmailVerification(String email) async {
    try {
      await pocketbase.collection("users").requestVerification(email);
      return Result();
    } on ClientException catch (e) {
      return Result(error: e);
    }
  }

  Future<Result<void, ClientException>> confirmEmailVerification(String token) async {
    try {
      await pocketbase.collection("users").confirmVerification(token);
      return Result();
    } on ClientException catch (e) {
      return Result(error: e);
    }
  }

  Future<Result<void, ClientException>> requestPasswordReset(String email) async {
    const url = '/api/collections/users/request-password-reset';
    final response = await dio.post(url, data: {'email': email});
    if (response.statusCode == 204) {
      return Result(
        error: ClientException(
          isAbort: false,
          response: {'message': 'Email not found'},
          url: Uri.parse(url),
        ),
      );
    }
    return Result();
  }
}
