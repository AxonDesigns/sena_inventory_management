class ProductState {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductState({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductState.fromJson(Map<String, dynamic> json) {
    return ProductState(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      createdAt: DateTime.parse(json["created"]),
      updatedAt: DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "created": createdAt.toIso8601String(),
      "updated": updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "ProductState(id: $id,  name: $name,  description: $description,  createdAt: $createdAt,  updatedAt: $updatedAt)";
  }
}
