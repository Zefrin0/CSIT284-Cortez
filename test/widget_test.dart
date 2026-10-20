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

  testWidgets('opens the new expense form and validates empty input', (
    tester,
  ) async {
    await tester.pumpWidget(const ExpenseTrackerApp());

    await tester.tap(find.text('New expense'));
    await tester.pumpAndSettle();

    expect(find.text('New expense'), findsNWidgets(2));
    expect(find.text('What was it for?'), findsOneWidget);

    await tester.tap(find.text('Add expense'));
    await tester.pumpAndSettle();

    expect(find.text('Almost there'), findsOneWidget);
    expect(
      find.text('Add a title, a positive amount, and a date.'),
      findsOneWidget,
    );
  });

  testWidgets(
    'opens expense details and handles a result returned from the route',
    (tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      await tester.tap(find.text('Coffee and toast'));
      await tester.pumpAndSettle();

      expect(find.text('Expense details'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
      await tester.tap(find.text('Mark as reviewed'));
      await tester.pumpAndSettle();

      expect(find.text('Expense marked as reviewed.'), findsOneWidget);
      expect(find.byTooltip('Reviewed'), findsOneWidget);
    },
  );

  testWidgets(
    'navigates to insights with expense data and applies theme settings',
    (tester) async {
      await tester.pumpWidget(const ExpenseTrackerApp());

      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Spending insights'));
      await tester.pumpAndSettle();

      expect(find.text('Category breakdown'), findsOneWidget);
      expect(find.text('₱ 498.49'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownButtonFormField<ThemeMode>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dark').last);
      await tester.pumpAndSettle();

      expect(
        tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
        ThemeMode.dark,
      );
    },
  );
}
