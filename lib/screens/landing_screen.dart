import 'package:flutter/material.dart';
import 'package:p0kemon/screens/register_screen.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display an image
            Image.asset(
              'assets/logo_pokemon.png', // Path to your image in the assets folder
              width: 200,
              height: 200,
            ),
            SizedBox(
                height: 20), // Add spacing between the image and the button
            // Create a button
            ElevatedButton(
              onPressed: () {
                // Navigate to the RegisterScreen
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                backgroundColor: Colors.orange,
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
