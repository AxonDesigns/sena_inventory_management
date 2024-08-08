import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class Role extends Model {
  final String name;
  final String description;
  final int privilege;

  Role({
    required super.id,
    required this.name,
    required this.description,
    required this.privilege,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory Role.fromRecord(RecordModel record) {
    return Role(
      id: record.id,
      name: record.getStringValue('name'),
      description: record.getStringValue('description'),
      privilege: record.getIntValue('privilege'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'privilege': privilege,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }
}
