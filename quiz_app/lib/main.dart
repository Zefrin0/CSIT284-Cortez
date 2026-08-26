import 'package:flutter/material.dart';

void rollDice() {
 
}
void main() {
  runApp(
    MaterialApp(
    home: Scaffold(
      backgroundColor: const Color.fromARGB(255, 178, 18, 218),
      body: Container(
        decoration: BoxDecoration(
        ),
        child: Center(
          child: Column( 
            mainAxisSize: MainAxisSize.min,
            children:[ 
              Image.asset(width: 200, 'assets/logo.png'),
              SizedBox(height: 20)

          
                Text(style: TextStyle(fontSize: 20, color: Colors.white), "learn Flutter the fun way!"),
              
              TextButton(
                onPressed: () {},
                child: Text(style: TextStyle(fontSize: 20, color: Colors.white), "Start Quiz"),
              ),
              
            ]
          ),
          ),
        ),
      ),
    ),
  );
}


 