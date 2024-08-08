import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/domain.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class Product extends Model {
  final List<String> images;
  final String name;
  final String description;
  final ProductState state;
  final double price;
  final Unit unit;
  final List<Category> categories;
  List<String> urls;

  Product({
    required super.id,
    required this.images,
    required this.name,
    required this.description,
    required this.state,
    required this.price,
    required this.unit,
    required this.categories,
    required super.created,
    required super.updated,
    this.urls = const [],
  }) : super(record: RecordModel());

  factory Product.fromRecord(RecordModel model) {
    return Product(
      id: model.id,
      images: model.getListValue('images', <String>[]),
      name: model.getStringValue('name'),
      description: model.getStringValue('description'),
      state: ProductState.fromRecord(model.expand['state']!.first),
      price: model.getDoubleValue('price'),
      unit: Unit.fromRecord(model.expand['unit']!.first),
      categories: model.getListValue('expand.categories', <Category>[]),
      created: DateTime.parse(model.created),
      updated: DateTime.parse(model.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "state": state.toJson(),
      "price": price,
      "unit": unit.toJson(),
      "categories": categories.map((e) => e.toJson()).toList(),
      "created": created.toIso8601String(),
      "updated": updated.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Product(id: $id, images: $images, name: $name, description: $description, state: $state, price: $price, unit: $unit, categories: $categories, created: $created, updated: $updated)";
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
