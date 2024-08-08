import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class Department extends Model {
  Department({
    required super.id,
    required this.name,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory Department.fromRecord(RecordModel record) {
    return Department(
      id: record.id,
      name: record.getStringValue('name'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  final String name;

  toJson() => {
        'id': id,
        'name': name,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'Department(id: $id, name: $name, created: $created, updated: $updated)';
  }
}
