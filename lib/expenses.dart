import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
      title: 'Coffee and toast',
      amount: 68.50,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Monthly data',
      amount: 249.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: Category.bills,
    ),
    Expense(
      title: 'Weekend movie',
      amount: 180,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: Category.leisure,
    ),
  ];

  double get total => registeredExpenses.fold(0, (sum, item) => sum + item.amount);

  void openAddExpense() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() => registeredExpenses.add(expense));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense added to your ledger.')),
    );
  }

  void removeExpense(Expense expense) {
    final index = registeredExpenses.indexOf(expense);
    setState(() => registeredExpenses.remove(expense));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense removed.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(() => registeredExpenses.insert(index, expense)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ledger & Lime'),
        actions: [
          IconButton(
            onPressed: openAddExpense,
            tooltip: 'Add expense',
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = [
              _Overview(total: total, count: registeredExpenses.length),
              const SizedBox(height: 10),
              if (registeredExpenses.isEmpty)
                const _EmptyState()
              else
                ...registeredExpenses.map(
                  (expense) => Dismissible(
                    key: ValueKey(expense.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => removeExpense(expense),
                    background: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                    ),
                    child: ExpenseItem(expense: expense),
                  ),
                ),
            ];
            return width > 720
                ? Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: ListView(padding: const EdgeInsets.only(top: 12), children: content),
                    ),
                  )
                : ListView(padding: const EdgeInsets.only(top: 12), children: content);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openAddExpense,
        icon: const Icon(Icons.add),
        label: const Text('New expense'),
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({required this.total, required this.count});

  final double total;
  final int count;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      color: scheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('This month', style: TextStyle(color: scheme.onPrimary.withValues(alpha: .75))),
                  const SizedBox(height: 4),
                  Text(
                    'R ${total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: scheme.onPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 28,
              backgroundColor: scheme.onPrimary.withValues(alpha: .16),
              child: Text(
                '$count',
                style: TextStyle(color: scheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 80),
      child: Column(
        children: [
          Icon(Icons.auto_awesome, size: 48, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text('Your ledger is clear', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          const Text('Tap "New expense" to capture your next spend.'),
        ],
      ),
    );
  }
}
