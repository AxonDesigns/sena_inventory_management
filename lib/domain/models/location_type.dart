class LocationType {
  LocationType({
    required this.id,
    required this.name,
    required this.description,
    required this.created,
    required this.updated,
  });

  factory LocationType.fromJson(Map<String, dynamic> json) {
    return LocationType(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  final String id;
  final String name;
  final String description;
  final DateTime created;
  final DateTime updated;

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
