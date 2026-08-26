import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 216, 216),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.blue,
          ])
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                width: 2000,
                'assets/dice-images/dice-images/dice-2.png'
                ),
              SizedBox(height: 30),
              TextButton(onPressed: () (), 
              child: Text(
                style: TextStyle(
                 fontSize: 28
                ),
                "Roll Dice"
                )
              ),
            ],
          )
        ),
      ),
    ),
  ),
  );
}