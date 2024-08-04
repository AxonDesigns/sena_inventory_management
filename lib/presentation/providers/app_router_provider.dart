import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sena_inventory_management/core/config/app_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return appRouter(ref);
});
