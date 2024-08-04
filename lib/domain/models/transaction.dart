import 'models.dart';

class Transaction {
  Transaction({
    required this.id,
    required this.type,
    required this.responsible,
    required this.source,
    required this.destination,
    required this.description,
    required this.created,
    required this.updated,
    required this.productTransactions,
  });

  factory Transaction.fromJson(Map<String, dynamic> json, List<ProductTransaction> productTransactions) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      responsible: User.fromJson(json['expand']['responsible']),
      source: Location.fromJson(json['expand']['source']),
      destination: Location.fromJson(json['expand']['destination']),
      description: json['description'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      productTransactions: productTransactions,
    );
  }

  final String id;
  final String type;
  final User responsible;
  final Location source;
  final Location destination;
  final String? description;
  final DateTime created;
  final DateTime updated;
  final List<ProductTransaction> productTransactions;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'responsible': responsible.toJson(),
        'source': source.toJson(),
        'destination': destination.toJson(),
        'description': description,
        'created': created.toIso8601String(),
        'updated': updated.toIso8601String(),
      };

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, responsible: $responsible, source: $source, destination: $destination, description: $description, created: $created, updated: $updated)';
  }
}
