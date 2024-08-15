import 'package:pocketbase/pocketbase.dart';
import 'package:sena_inventory_management/domain/models/model.dart';

import 'models.dart';

class Transaction extends Model {
  Transaction({
    required super.id,
    required this.type,
    required this.status,
    required this.responsable,
    required this.source,
    required this.destination,
    required this.description,
    required super.created,
    required super.updated,
    required this.productTransactions,
  }) : super(record: RecordModel());

  factory Transaction.fromRecord(RecordModel record, List<ProductTransaction> productTransactions, [User? responsable]) {
    return Transaction(
      id: record.id,
      status: record.getStringValue('status'),
      type: record.getStringValue('type'),
      responsable: responsable ?? User.fromRecord(record.expand['responsable']!.first),
      source: Location.fromRecord(record.expand['source']!.first),
      destination: Location.fromRecord(record.expand['destination']!.first),
      description: record.getStringValue('description'),
      created: DateTime.parse(record.created),
      updated: DateTime.parse(record.updated),
      productTransactions: productTransactions,
    );
  }

  final String type;
  final String status;
  final User responsable;
  final Location source;
  final Location destination;
  final String? description;
  final List<ProductTransaction> productTransactions;

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'type': type,
        'responsible': responsable.toJson(),
        'source': source.toJson(),
        'destination': destination.toJson(),
        'description': description,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, responsable: $responsable, source: $source, destination: $destination, description: $description, created: $created, updated: $updated)';
  }
}
