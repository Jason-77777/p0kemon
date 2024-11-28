class BidModel {
  final int id;
  final String cardName; // Nama kartu
  final double bidPrice; // Harga tawaran
  final String status; // Status tawaran

  BidModel({
    required this.id,
    required this.cardName,
    required this.bidPrice,
    required this.status,
  });

  // Factory method to create an instance from JSON
  factory BidModel.fromJson(Map<String, dynamic> json) {
    return BidModel(
      id: int.parse(json['id'].toString()),
      cardName: json['card_name'] ?? '', // Ganti dengan card_name
      bidPrice: double.parse(json['bid_price'].toString()),
      status: json['status'] ?? '',
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'card_name': cardName, // Ganti dengan card_name
      'bid_price': bidPrice,
      'status': status,
    };
  }
}
