import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
    this.onTap,
    this.reviewed = false,
  });

  final Expense expense;
  final VoidCallback? onTap;
  final bool reviewed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          child: Icon(categoryIcons[expense.category]),
        ),
        title: Row(
          children: [
            Expanded(child: Text(expense.title)),
            if (reviewed) ...[
              const SizedBox(width: 6),
              Tooltip(
                message: 'Reviewed',
                child: Icon(
                  Icons.check_circle,
                  size: 17,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${categoryLabels[expense.category]}  •  ${expense.date.day}/${expense.date.month}/${expense.date.year}',
        ),
        trailing: Text(
          '$currencySymbol ${expense.amount.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        onTap: onTap,
      ),
    );
  }
}
