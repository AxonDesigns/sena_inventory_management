import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

final authProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    pocketbase: ref.read(pocketBaseProvider),
    roleRepository: ref.read(roleRepositoryProvider),
  );
});
