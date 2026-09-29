import 'package:flutter/material.dart';

enum Category { food, travel, leisure, work, bills }

const categoryIcons = {
  Category.food: Icons.restaurant,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie_outlined,
  Category.work: Icons.work_outline,
  Category.bills: Icons.receipt_long,
};

const categoryLabels = {
  Category.food: 'Food',
  Category.travel: 'Travel',
  Category.leisure: 'Leisure',
  Category.work: 'Work',
  Category.bills: 'Bills',
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = DateTime.now().microsecondsSinceEpoch.toString();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
