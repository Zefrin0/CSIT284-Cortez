import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseDetailsArguments {
  const ExpenseDetailsArguments({required this.expense, this.reviewed = false});

  final Expense expense;
  final bool reviewed;
}

class ExpenseDetailsScreen extends StatelessWidget {
  const ExpenseDetailsScreen({super.key, required this.arguments});

  final ExpenseDetailsArguments arguments;

  @override
  Widget build(BuildContext context) {
    final expense = arguments.expense;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Expense details')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CircleAvatar(
            radius: 34,
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            child: Icon(categoryIcons[expense.category], size: 30),
          ),
          const SizedBox(height: 18),
          Text(
            expense.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 6),
          Text(
            '$currencySymbol ${expense.amount.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Category'),
                  trailing: Text(categoryLabels[expense.category]!),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text('Date'),
                  trailing: Text(
                    '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: arguments.reviewed
                ? null
                : () => Navigator.pop(context, true),
            icon: Icon(
              arguments.reviewed ? Icons.check_circle : Icons.task_alt,
            ),
            label: Text(arguments.reviewed ? 'Reviewed' : 'Mark as reviewed'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Reviewing an expense helps you keep your ledger up to date.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
