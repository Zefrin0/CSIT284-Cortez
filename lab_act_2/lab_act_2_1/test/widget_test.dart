// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab_act_2_1/main.dart';
import 'package:lab_act_2_1/dice.roller.dart';

void main() {
  testWidgets('dice roller changes image when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: DiceRoller()));

    expect(find.text('Roll Dice'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    final initialImage = tester.widget<Image>(find.byType(Image)).image;
    await tester.tap(find.text('Roll Dice'));
    await tester.pump();

    final rolledImage = tester.widget<Image>(find.byType(Image)).image;
    expect(rolledImage, isNot(equals(initialImage)));
  });
}
