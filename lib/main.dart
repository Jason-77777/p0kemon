import 'package:flutter/material.dart';
import 'package:p0kemon/screens/register_screen.dart';
import 'package:p0kemon/screens/login_screen.dart';
import 'package:p0kemon/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      initialRoute: '/register',
      routes: {
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Tambahkan HomeScreen Anda
      },
    );
  }
}
