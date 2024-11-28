class CardModel {
  final int id;
  final String name;
  final String type;
  final String rarity;
  final String description;
  final double price;

  CardModel({
    required this.id,
    required this.name,
    required this.type,
    required this.rarity,
    required this.description,
    required this.price,
  });

  // Factory method to create an instance from JSON
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: int.tryParse(json['id'].toString()) ?? 0, // Ensure it's an int
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      rarity: json['rarity'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is String
          ? double.tryParse(json['price']) ?? 0.0
          : json['price'] is int
              ? (json['price'] as int).toDouble()
              : 0.0, // Convert price correctly
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'rarity': rarity,
      'description': description,
      'price': price,
    };
  }
}
