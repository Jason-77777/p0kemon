import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p0kemon/models/profile_model.dart'; // Pastikan path ini sesuai dengan struktur Anda

class ApiService {
  static const String _baseUrl = 'http://localhost/APIpokemon/auth.php';

  // Fungsi untuk melakukan registrasi
  Future<Profile?> registerUser(
      String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action':
              'register', // Menambahkan action untuk menentukan bahwa ini adalah permintaan registrasi
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        if (responseBody['status'] == 200) {
          // Berhasil registrasi
          print('Registrasi berhasil: ${responseBody['data']}');
          return Profile.fromJson(responseBody['data']);
        } else {
          // Error dari API
          throw Exception('Registrasi gagal: ${responseBody['message']}');
        }
      } else {
        // Error status kode HTTP
        throw Exception('Gagal terhubung ke server: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error pada registerUser: $e');
      rethrow; // Lempar kembali error ke pemanggil
    }
  }

  // Fungsi untuk login
  Future<Profile?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'login', // Menambahkan action untuk login
          'email': email,
          'password': password,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        if (responseBody['status'] == 200) {
          // Berhasil login
          print('Login berhasil: ${responseBody['data']}');
          return Profile.fromJson(responseBody['data']);
        } else {
          // Error dari API
          throw Exception('Login gagal: ${responseBody['message']}');
        }
      } else {
        // Error status kode HTTP
        throw Exception('Gagal terhubung ke server: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error pada loginUser: $e');
      rethrow; // Lempar kembali error ke pemanggil
    }
  }
}
