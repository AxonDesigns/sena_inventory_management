import 'package:pocketbase/pocketbase.dart';

abstract class Model {
  Model({
    required this.id,
    required this.created,
    required this.updated,
    required this.record,
  });

  final RecordModel record;
  final String id;
  final DateTime created;
  final DateTime updated;

  @override
  String toString() {
    return record.toString();
  }
}
