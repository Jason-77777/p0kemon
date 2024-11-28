// lib/models/profile_model.dart

class Profile {
  final int id;
  final String name;
  final String email;
  final String password;
  final String createdAt;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  // Method untuk membuat objek Profile dari JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] is int
          ? json['id']
          : int.parse(json['id'].toString()), // Menghindari error parsing
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  // Method untuk mengubah objek Profile menjadi Map untuk dikirim ke API
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }
}
