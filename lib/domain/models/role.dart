class Role {
  final String id;
  final String name;
  final String description;
  final int privilege;

  const Role({
    required this.id,
    required this.name,
    required this.description,
    required this.privilege,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      privilege: int.parse(json['privilege'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'privilege': privilege,
    };
  }
}
