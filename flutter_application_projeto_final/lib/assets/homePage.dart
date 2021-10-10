import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ------------------ CONTAINER PRINCIPAL --------------------
    return Container(
      padding: EdgeInsets.only(top:50, right: 30, bottom: 30, left: 30),
      color: Colors.brown.shade200,
      child: Column(
        children: [
            Text('Tema',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              )
            ),
        ],
      ),
    );
  }
}
