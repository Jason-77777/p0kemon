import 'package:flutter/material.dart';
import 'package:p0kemon/widgets/base_layout.dart';
import 'package:p0kemon/screens/card_screen.dart'; // Import CardScreen
import 'package:p0kemon/screens/bid_screen.dart'; // Import BidScreen
import 'package:p0kemon/screens/battle_screen.dart'; // Import BattleScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      selectedIndex: 0, // Menunjukkan tab "Card" di navbar
      bodyContent: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo_pokemon.png', // Path to the GIF in your assets folder
            ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => CardScreen()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(200, 100),
            //     backgroundColor: Colors.grey[300],
            //   ),
            //   child: Text('Your Collection'),
            // ),
            // SizedBox(height: 20),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => BidScreen()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     minimumSize: Size(200, 100),
            //     backgroundColor: Colors.grey[300],
            //   ),
            //   child: Text('Bids Card'),
            // ),
          ],
        ),
      ),
    );
  }
}
