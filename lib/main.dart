import 'package:flutter/material.dart';

import 'package:expense_tracker/expenses.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/expense_details_screen.dart';
import 'package:expense_tracker/screens/insights_screen.dart';
import 'package:expense_tracker/screens/settings_screen.dart';
import 'package:expense_tracker/widgets/app_routes.dart';

const seedColor = Color(0xFF2F6F64);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: seedColor,
  brightness: Brightness.light,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF8DD8B8),
  brightness: Brightness.dark,
);

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  @override
  State<ExpenseTrackerApp> createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ledger & Lime',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: const Color(0xFFF5F7F3),
        appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme.surface,
          foregroundColor: lightColorScheme.onSurface,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: lightColorScheme.surface,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: lightColorScheme.outlineVariant),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: lightColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        scaffoldBackgroundColor: const Color(0xFF101916),
        cardTheme: CardThemeData(
          color: darkColorScheme.surfaceContainer,
          elevation: 0,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: darkColorScheme.outlineVariant),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: darkColorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const Expenses(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.insights:
            final expenses = settings.arguments;
            if (expenses is! List<Expense>) {
              throw ArgumentError(
                'Insights route requires a list of expenses.',
              );
            }
            return MaterialPageRoute<void>(
              builder: (_) => InsightsScreen(expenses: expenses),
              settings: settings,
            );
          case AppRoutes.settings:
            return MaterialPageRoute<void>(
              builder: (_) => SettingsScreen(
                themeMode: _themeMode,
                onThemeModeChanged: (mode) => setState(() => _themeMode = mode),
              ),
              settings: settings,
            );
          case AppRoutes.expenseDetails:
            final arguments = settings.arguments;
            if (arguments is! ExpenseDetailsArguments) {
              throw ArgumentError(
                'Expense details route requires expense details arguments.',
              );
            }
            return MaterialPageRoute<bool>(
              builder: (_) => ExpenseDetailsScreen(arguments: arguments),
              settings: settings,
            );
          default:
            return null;
        }
      },
    );
  }
}
