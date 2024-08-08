import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class ProductState extends Model {
  final String name;
  final String description;

  ProductState({
    required super.id,
    required this.name,
    required this.description,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory ProductState.fromRecord(RecordModel record) {
    return ProductState(
      id: record.id,
      name: record.getStringValue('name'),
      description: record.getStringValue('description'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "created": created.toIso8601String(),
      "updated": updated.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "ProductState(id: $id,  name: $name,  description: $description,  createdAt: $created,  updatedAt: $updated)";
  }
}
