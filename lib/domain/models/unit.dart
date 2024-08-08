import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

class Unit extends Model {
  final String symbol;
  final String name;

  Unit({
    required super.id,
    required this.symbol,
    required this.name,
    required super.created,
    required super.updated,
  }) : super(record: RecordModel());

  factory Unit.fromRecord(RecordModel record) {
    return Unit(
      id: record.id,
      symbol: record.getStringValue('symbol'),
      name: record.getStringValue('name'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symbol": symbol,
      "name": name,
      "created": created.toIso8601String(),
      "updated": updated.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Unit(id: $id,  symbol: $symbol,  name: $name,  createdAt: $created,  updatedAt: $updated)";
  }
}
