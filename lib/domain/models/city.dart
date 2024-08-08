import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/department.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class City extends Model {
  City({
    required super.id,
    required this.name,
    required this.department,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory City.fromRecord(RecordModel record) {
    return City(
      id: record.id,
      name: record.getStringValue('name'),
      department: Department.fromRecord(record.expand['department']!.first),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  final String name;
  final Department department;

  toJson() => {
        'id': id,
        'name': name,
        'department': department.toJson(),
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'City(id: $id, name: $name, department: $department, created: $created, updated: $updated)';
  }
}
