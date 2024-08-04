import 'package:sena_inventory_management/domain/domain.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final ProductType type;
  final ProductState state;
  final double price;
  final Unit unit;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.state,
    required this.price,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      type: ProductType.fromJson(json["expand"]["type"]),
      state: ProductState.fromJson(json["expand"]["state"]),
      price: double.parse(json["price"].toString()),
      unit: Unit.fromJson(json["expand"]["unit"]),
      createdAt: DateTime.parse(json["created"]),
      updatedAt: DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "type": type.toJson(),
      "state": state.toJson(),
      "price": price,
      "unit": unit.toJson(),
      "created": createdAt.toIso8601String(),
      "updated": updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Product(id: $id, name: $name, description: $description, type: $type, state: $state, price: $price, unit: $unit, createdAt: $createdAt, updatedAt: $updatedAt)";
  }
}

class ProductDTO {
  final String name;
  final String description;
  final String type;
  final String state;
  final double price;
  final String unit;

  ProductDTO({
    required this.name,
    required this.description,
    required this.type,
    required this.state,
    required this.price,
    required this.unit,
  });

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(
      name: json["name"],
      description: json["description"],
      type: json["type"],
      state: json["state"],
      price: double.parse(json["price"].toString()),
      unit: json["unit"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "type": type,
      "state": state,
      "price": price,
      "unit": unit,
    };
  }
}
