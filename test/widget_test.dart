import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('shows the ledger overview and starter expenses', (tester) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    expect(find.text('Ledger & Lime'), findsOneWidget);
    expect(find.text('This month'), findsOneWidget);
    expect(find.text('Spending by category'), findsOneWidget);
    expect(find.text('Coffee and toast'), findsOneWidget);
    expect(find.text('Monthly data'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    expect(find.text('Weekend movie'), findsOneWidget);
  });

  testWidgets('opens the new expense form and validates empty input', (tester) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    await tester.tap(find.text('New expense'));
    await tester.pumpAndSettle();

    expect(find.text('New expense'), findsNWidgets(2));
    expect(find.text('What was it for?'), findsOneWidget);

    await tester.tap(find.text('Add expense'));
    await tester.pumpAndSettle();

    expect(find.text('Almost there'), findsOneWidget);
    expect(find.text('Add a title, a positive amount, and a date.'), findsOneWidget);
  });
}
