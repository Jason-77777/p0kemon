import 'package:flutter/material.dart';
import 'package:p0kemon/screens/card_screen.dart';
import 'package:p0kemon/screens/bid_screen.dart';
import 'package:p0kemon/screens/battle_screen.dart';
import 'package:p0kemon/main.dart'; // Import main.dart for navigation

class BaseLayout extends StatelessWidget {
  final int selectedIndex;
  final Widget bodyContent;
  final FloatingActionButton? floatingActionButton; // Make this optional

  BaseLayout({
    required this.selectedIndex,
    required this.bodyContent,
    this.floatingActionButton, // Optional parameter
  });

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CardScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BidScreen()), // Fix method name
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BattleScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pokemon App')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              accountName: Text('Name', style: TextStyle(fontSize: 20)),
              accountEmail: Text('example@email.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Log out and navigate to the initial screen (main.dart)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp()), // Navigate to main.dart
                  (route) =>
                      false, // Removes all previous routes from the stack
                );
              },
            ),
          ],
        ),
      ),
      body: bodyContent,
      floatingActionButton: floatingActionButton, // Include FAB here
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Bid',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_martial_arts),
            label: 'Battle',
          ),
        ],
      ),
    );
  }
}
