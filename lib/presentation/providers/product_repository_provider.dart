import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(pocketBase: ref.watch(pocketBaseProvider));
});
