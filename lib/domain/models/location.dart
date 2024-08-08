import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/city.dart';
import 'package:sena_inventory_management/domain/models/model.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class Location extends Model {
  Location({
    required super.id,
    required this.name,
    required this.address,
    required this.city,
    required this.type,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory Location.fromRecord(RecordModel record) {
    return Location(
      id: record.id,
      name: record.getStringValue('name'),
      address: record.getStringValue('address'),
      city: City.fromRecord(record.expand['city']!.first),
      type: LocationType.fromRecord(record.expand['type']!.first),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  final String name;
  final String address;
  final City city;
  final LocationType type;

  toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'city': city.toJson(),
        'type': type.toJson(),
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'Location(id: $id, name: $name, address: $address, city: $city, type: $type, created: $created, updated: $updated)';
  }
}
