import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';

final pocketBaseProvider = Provider<PocketBase>((ref) {
  return PocketBase("http://localhost:8090");
});
