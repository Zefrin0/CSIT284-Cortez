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
          child: Text("Hello World"),
        ),
      ),
    ),
  ),
  );
}