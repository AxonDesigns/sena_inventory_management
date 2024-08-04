class Department {
  Department({
    required this.id,
    required this.name,
    required this.created,
    required this.updated,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  final String id;
  final String name;
  final DateTime created;
  final DateTime updated;

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
