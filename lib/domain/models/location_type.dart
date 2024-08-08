import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class LocationType extends Model {
  LocationType({
    required super.id,
    required this.name,
    required this.description,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory LocationType.fromRecord(RecordModel record) {
    return LocationType(
      id: record.id,
      name: record.getStringValue('name'),
      description: record.getStringValue('description'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  final String name;
  final String description;

  toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'LocationType(id: $id, name: $name, description: $description, created: $created, updated: $updated)';
  }
}
