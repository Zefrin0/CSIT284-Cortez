import 'package:flutter/material.dart';
import 'package:lab_act_2_1/dice.roller.dart';

void rollDice() {
 
}
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
        child: DiceRoller(),
        ),
      ),
    ),
  );
}