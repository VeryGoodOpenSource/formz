import 'package:example/async_form.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final Finder _usernameInput = find.byKey(const Key('asyncForm_usernameInput'));
final Finder _submitButton = find.byKey(const Key('asyncForm_submit'));

void main() {
  group('$MyApp', () {
    testWidgets('renders $AsyncForm in the async validation tab', (
      tester,
    ) async {
      await tester.pumpWidget(const MyApp());

      await tester.tap(find.text('Async validation'));
      await tester.pumpAndSettle();

      expect(find.byType(AsyncForm), findsOneWidget);
    });
  });

  group('$AsyncForm', () {
    testWidgets('submit is disabled initially', (tester) async {
      await tester.pumpAsyncForm();

      expect(tester.isSubmitEnabled, isFalse);
    });

    testWidgets('shows error when username is empty', (tester) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'joe');
      await tester.pumpAndSettle();
      await tester.enterText(_usernameInput, '');
      await tester.pumpAndSettle();

      expect(find.text('Please enter a username'), findsOneWidget);
      expect(tester.isSubmitEnabled, isFalse);
    });

    testWidgets('shows error without checking when username is too short', (
      tester,
    ) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'jo');
      await tester.pump();

      expect(
        find.text('Username must be at least 3 characters'),
        findsOneWidget,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(tester.isSubmitEnabled, isFalse);
    });

    testWidgets('shows progress indicator while checking username', (
      tester,
    ) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'joe');
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.isSubmitEnabled, isFalse);

      await tester.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(tester.isSubmitEnabled, isTrue);
    });

    testWidgets('shows error when username is already taken', (tester) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'Dash');
      await tester.pumpAndSettle();

      expect(find.text('This username is already taken'), findsOneWidget);
      expect(tester.isSubmitEnabled, isFalse);
    });

    testWidgets('ignores result of an outdated check', (tester) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'joe');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(_usernameInput, 'dash');
      await tester.pumpAndSettle();

      expect(find.text('This username is already taken'), findsOneWidget);
      expect(tester.isSubmitEnabled, isFalse);
    });

    testWidgets('submits and resets the form', (tester) async {
      await tester.pumpAsyncForm();

      await tester.enterText(_usernameInput, 'joe');
      await tester.pumpAndSettle();
      await tester.tap(_submitButton);
      await tester.pumpAndSettle();

      expect(find.text('Welcome, joe! 🎉'), findsOneWidget);
      expect(
        tester.widget<TextField>(_usernameInput).controller!.text,
        isEmpty,
      );
      expect(find.text('Please enter a username'), findsNothing);
      expect(tester.isSubmitEnabled, isFalse);
    });
  });
}

extension on WidgetTester {
  Future<void> pumpAsyncForm() async {
    await pumpWidget(const MaterialApp(home: Scaffold(body: AsyncForm())));
  }

  bool get isSubmitEnabled =>
      widget<ElevatedButton>(_submitButton).onPressed != null;
}
