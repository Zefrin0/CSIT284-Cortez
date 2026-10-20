import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final total = expenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Spending insights')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          Card(
            color: scheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tracked expenses', style: themeLabelStyle(context)),
                  const SizedBox(height: 6),
                  Text(
                    '$currencySymbol ${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${expenses.length} total entries'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
            child: Text(
              'Category breakdown',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          ...Category.values.map((category) {
            final categoryExpenses = expenses
                .where((expense) => expense.category == category)
                .toList();
            final amount = categoryExpenses.fold<double>(
              0,
              (sum, item) => sum + item.amount,
            );
            final share = total == 0 ? 0.0 : amount / total;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(categoryIcons[category], color: scheme.primary),
                        const SizedBox(width: 10),
                        Expanded(child: Text(categoryLabels[category]!)),
                        Text('$currencySymbol ${amount.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: share),
                    const SizedBox(height: 4),
                    Text(
                      '${(share * 100).toStringAsFixed(0)}% of tracked spending',
                    ),
                  ],
                ),
              ),
            );
          }),
          if (expenses.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Add an expense to see your spending insights.'),
            ),
        ],
      ),
    );
  }

  TextStyle? themeLabelStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer);
}
