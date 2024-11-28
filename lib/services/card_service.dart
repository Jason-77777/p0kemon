import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p0kemon/models/card_model.dart'; // Import your CardModel

class CardService {
  static const String _baseUrl = 'http://localhost/APIpokemon/cards.php';

  // Fetch cards from API
  Future<List<CardModel>> fetchCards() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Map API response to CardModel instances
      return (body['data'] as List)
          .map((json) => CardModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load cards');
    }
  }

  // Create a card
  Future<void> createCard(Map<String, dynamic> cardData) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cardData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create card');
    }
  }

  // Update a card
  Future<void> updateCard(int id, Map<String, dynamic> cardData) async {
    final response = await http.put(
      Uri.parse('$_baseUrl?id=$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cardData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update card');
    }
  }

  // Delete a card
  Future<void> deleteCard(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl?id=$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete card');
    }
  }
}
