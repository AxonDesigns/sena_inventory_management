class Unit {
  final String id;
  final String symbol;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Unit({
    required this.id,
    required this.symbol,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json["id"],
      symbol: json["symbol"],
      name: json["name"],
      createdAt: DateTime.parse(json["created"]),
      updatedAt: DateTime.parse(json["updated"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symbol": symbol,
      "name": name,
      "created": createdAt.toIso8601String(),
      "updated": updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return "Unit(id: $id,  symbol: $symbol,  name: $name,  createdAt: $createdAt,  updatedAt: $updatedAt)";
  }
}

///
/// `users.username = ${user.username}`
/// 'username = ' + user.username
///  