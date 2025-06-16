import 'dart:math';

import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRandom extends Mock implements Random {}

final _seed = MockRandom();

void main() {
  group('$MyApp', () {
    testWidgets('render example', (tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.text('Formz Example'), findsOneWidget);
    });
  });

  group('$MyForm', () {
    setUp(() {
      when(() => _seed.nextInt(any())).thenReturn(1);
    });

    testWidgets('submits valid values', (tester) async {
      await tester.pumpMyForm();

      await tester.enterText(
        find.byKey(const Key('myForm_emailInput')),
        'email@example.com',
      );
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('myForm_passwordInput')),
        '123password',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('myForm_submit')));
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      expect(find.text('Submitted successfully! 🎉'), findsOneWidget);
    });

    group('invalid values', () {
      testWidgets('invalid email', (tester) async {
        await tester.pumpMyForm();

        await tester.enterText(
          find.byKey(const Key('myForm_emailInput')),
          'example.com',
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('myForm_passwordInput')),
          '123password',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('myForm_submit')));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        expect(
          find.text('Please ensure the email entered is valid'),
          findsOneWidget,
        );
      });

      testWidgets('empty email', (tester) async {
        await tester.pumpMyForm();

        await tester.enterText(
          find.byKey(const Key('myForm_emailInput')),
          '',
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('myForm_passwordInput')),
          '123password',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('myForm_submit')));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        expect(
          find.text('Please ensure the email entered is valid'),
          findsOneWidget,
        );
      });

      testWidgets('invalid password', (tester) async {
        await tester.pumpMyForm();

        await tester.enterText(
          find.byKey(const Key('myForm_emailInput')),
          'email@example.com',
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('myForm_passwordInput')),
          '12345678',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('myForm_submit')));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        expect(
          find.text(
              '''Password must be at least 8 characters and contain at least one letter and number'''),
          findsOneWidget,
        );
      });

      testWidgets('empty password', (tester) async {
        await tester.pumpMyForm();

        await tester.enterText(
          find.byKey(const Key('myForm_emailInput')),
          'email@example.com',
        );
        await tester.pumpAndSettle();

        await tester.enterText(
          find.byKey(const Key('myForm_passwordInput')),
          '',
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('myForm_submit')));
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();

        expect(
          find.text(
              '''Password must be at least 8 characters and contain at least one letter and number'''),
          findsOneWidget,
        );
      });
    });
  });
}

extension on WidgetTester {
  Future<void> pumpMyForm() async {
    await pumpWidget(MaterialApp(home: Scaffold(body: MyForm(seed: _seed))));
  }
}
