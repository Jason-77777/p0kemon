import 'package:flutter/material.dart';
import 'package:p0kemon/screens/register_screen.dart';
import 'package:p0kemon/screens/login_screen.dart';
import 'package:p0kemon/screens/home_screen.dart';
import 'package:p0kemon/screens/landing_screen.dart'; // Import LandingScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      initialRoute: '/landing', // Set initial route to LandingScreen
      routes: {
        '/landing': (context) => LandingScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
