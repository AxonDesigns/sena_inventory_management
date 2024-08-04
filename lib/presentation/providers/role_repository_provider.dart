import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

final roleRepositoryProvider = Provider<RoleRepository>((ref) {
  return RoleRepository(pocketbase: ref.watch(pocketBaseProvider));
});
