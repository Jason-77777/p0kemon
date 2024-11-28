import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p0kemon/models/bid_model.dart'; // Import BidModel

class BidService {
  static const String _baseUrl = 'http://localhost/APIpokemon/bids.php';

  // Fetch bids from API
  Future<List<BidModel>> fetchBids() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Map API response to BidModel instances
      return (body['data'] as List)
          .map((json) => BidModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load bids');
    }
  }

  // Fetch a specific bid by ID
  Future<BidModel> fetchBidById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl?id=$id'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return BidModel.fromJson(body['data']);
    } else {
      throw Exception('Failed to load bid');
    }
  }

  // Create a bid
  Future<void> createBid(Map<String, dynamic> bidData) async {
    try {
      // Make the POST request
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(bidData),
      );

      // Check for HTTP response status
      if (response.statusCode != 201 && response.statusCode != 200) {
        // Throw an error with API response details for better debugging
        throw Exception(
            'Failed to create bid: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // Log the error (optional) and rethrow it for further handling
      print('Error creating bid: $e');
      throw Exception('Error occurred while creating bid');
    }
  }

  // Update a bid
  Future<void> updateBid(int id, Map<String, dynamic> bidData) async {
    final response = await http.put(
      Uri.parse('$_baseUrl?id=$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bidData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update bid');
    }
  }

  // update method deleteBid in BidService
  Future<void> deleteBid(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl?id=$id'),
        headers: {'Content-Type': 'application/json'},
      );

      // Memeriksa status response dari API
      if (response.statusCode == 200) {
        print('Bid deleted successfully');
      } else {
        // Jika API tidak mengembalikan status 200, lempar exception
        throw Exception('Failed to delete bid');
      }
    } catch (e) {
      print('Error deleting bid: $e');
      throw Exception('Failed to delete bid: $e');
    }
  }
}
