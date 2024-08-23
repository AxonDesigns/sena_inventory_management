import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/presentation/presentation.dart';

final transactionRepositoryProvider = Provider.autoDispose<TransactionRepository>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  final productRepository = ref.watch(productRepositoryProvider);
  return TransactionRepository(
    pocketBase: ref.watch(pocketBaseProvider),
    userRepository: userRepository,
    productRepository: productRepository,
  );
});
