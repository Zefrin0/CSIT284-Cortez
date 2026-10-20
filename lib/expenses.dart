import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/expense_details_screen.dart';
import 'package:expense_tracker/widgets/app_routes.dart';
import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final Set<String> reviewedExpenseIds = {};

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

  double get total =>
      registeredExpenses.fold(0, (sum, item) => sum + item.amount);

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
          onPressed: () =>
              setState(() => registeredExpenses.insert(index, expense)),
        ),
      ),
    );
  }

  Future<void> openInsights() {
    return Navigator.of(context).pushNamed<void>(
      AppRoutes.insights,
      arguments: List<Expense>.unmodifiable(registeredExpenses),
    );
  }

  Future<void> openExpense(Expense expense) async {
    final reviewed = await Navigator.of(context).pushNamed<bool>(
      AppRoutes.expenseDetails,
      arguments: ExpenseDetailsArguments(
        expense: expense,
        reviewed: reviewedExpenseIds.contains(expense.id),
      ),
    );
    if (reviewed == true && mounted) {
      setState(() => reviewedExpenseIds.add(expense.id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense marked as reviewed.')),
      );
    }
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
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Ledger & Lime',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Expense ledger'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.insights_outlined),
                title: const Text('Spending insights'),
                onTap: () {
                  Navigator.pop(context);
                  openInsights();
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.settings);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = [
              _Overview(total: total, count: registeredExpenses.length),
              _CategorySummary(expenses: registeredExpenses, total: total),
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
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
                    child: ExpenseItem(
                      expense: expense,
                      reviewed: reviewedExpenseIds.contains(expense.id),
                      onTap: () => openExpense(expense),
                    ),
                  ),
                ),
            ];
            final list = ListView.builder(
              padding: const EdgeInsets.only(top: 12),
              itemCount: content.length,
              itemBuilder: (context, index) => content[index],
            );
            return width > 720
                ? Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: list,
                    ),
                  )
                : list;
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
                  Text(
                    'This month',
                    style: TextStyle(
                      color: scheme.onPrimary.withValues(alpha: .75),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$currencySymbol ${total.toStringAsFixed(2)}',
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
                style: TextStyle(
                  color: scheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
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
          Icon(
            Icons.auto_awesome,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Your ledger is clear',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          const Text('Tap "New expense" to capture your next spend.'),
        ],
      ),
    );
  }
}

class _CategorySummary extends StatelessWidget {
  const _CategorySummary({required this.expenses, required this.total});

  final List<Expense> expenses;
  final double total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending by category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 14),
            ...Category.values.map((category) {
              final categoryTotal = expenses
                  .where((expense) => expense.category == category)
                  .fold(0.0, (sum, expense) => sum + expense.amount);
              final progress = total == 0 ? 0.0 : categoryTotal / total;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Icon(
                      categoryIcons[category],
                      size: 18,
                      color: scheme.primary,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(width: 62, child: Text(categoryLabels[category]!)),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 7,
                          backgroundColor: scheme.surfaceContainerHighest,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 70,
                      child: Text(
                        '$currencySymbol ${categoryTotal.toStringAsFixed(0)}',
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
