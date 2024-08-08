class Category {
  final String id;
  final String name;
  final DateTime created;
  final DateTime updated;

  Category({
    required this.id,
    required this.name,
    required this.created,
    required this.updated,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      created: DateTime.parse(json["created"]),
      updated: DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "created": created.toIso8601String(),
      "updated": updated.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, created: $created, updated: $updated)';
  }
}
