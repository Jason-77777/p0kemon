import 'package:flutter/material.dart';
import 'package:p0kemon/widgets/base_layout.dart';

class BattleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      selectedIndex: 2, // Menunjukkan tab "Battle"
      bodyContent: Center(
        child: Text('Battle not available right now',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
