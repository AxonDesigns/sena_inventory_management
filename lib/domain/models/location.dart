import 'package:sena_inventory_management/domain/models/city.dart';
import 'package:sena_inventory_management/domain/models/models.dart';

class Location {
  Location({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.type,
    required this.created,
    required this.updated,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      city: City.fromJson(json['expand']['city']),
      type: LocationType.fromJson(json['expand']['type']),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  final String id;
  final String name;
  final String address;
  final City city;
  final LocationType type;
  final DateTime created;
  final DateTime updated;

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
