import 'package:sena_inventory_management/domain/models/department.dart';

class City {
  City({
    required this.id,
    required this.name,
    required this.department,
    required this.created,
    required this.updated,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      department: Department.fromJson(json['expand']['department']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  final String id;
  final String name;
  final Department department;
  final DateTime created;
  final DateTime updated;

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
