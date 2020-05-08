import 'package:formz/formz.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

void main() {
  group('Formz', () {
    group('FormzInput', () {
      test('constructor throws AssertionError when value is null', () {
        expect(
          () => NameInput.pure(value: null),
          throwsA(isA<AssertionError>()),
        );
        expect(
          () => NameInput.dirty(value: null),
          throwsA(isA<AssertionError>()),
        );
      });

      test('value is correct', () {
        expect(NameInput.pure(value: 'joe').value, 'joe');
      });

      test('pure is true when super.pure is used', () {
        expect(NameInput.pure(value: 'joe').pure, isTrue);
      });

      test('pure is false when super.dirty is used', () {
        expect(NameInput.dirty(value: 'joe').pure, isFalse);
      });

      test('status is pure if super.pure is used', () {
        expect(NameInput.pure(value: 'joe').status, FormzInputStatus.pure);
      });

      test('status is valid if super.dirty is used and input is valid', () {
        expect(NameInput.dirty(value: 'joe').status, FormzInputStatus.valid);
      });

      test('status is invalid if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty(value: '').status, FormzInputStatus.invalid);
      });

      test('error is NameInputError.empty if pure is used', () {
        expect(NameInput.pure(value: '').error, NameInputError.empty);
      });

      test('error is null if super.dirty is used and input is valid', () {
        expect(NameInput.dirty(value: 'joe').error, isNull);
      });

      test(
          'error is NameInputError.empty '
          'if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty(value: '').error, NameInputError.empty);
      });

      test('valid is true if super.pure is used and input is valid', () {
        expect(NameInput.pure(value: 'joe').valid, isTrue);
      });

      test('valid is true if super.dirty is used and input is valid', () {
        expect(NameInput.dirty(value: 'joe').valid, isTrue);
      });

      test('valid is false if super.pure is used and input is invalid', () {
        expect(NameInput.pure(value: '').valid, isFalse);
      });

      test('valid is false if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty(value: '').valid, isFalse);
      });

      test('hashCode is correct', () {
        expect(
          NameInput.pure(value: '').hashCode,
          ''.hashCode ^ true.hashCode,
        );
        expect(
          NameInput.dirty(value: 'joe').hashCode,
          'joe'.hashCode ^ false.hashCode,
        );
      });

      test('== is value based', () {
        expect(NameInput.pure(), equals(NameInput.pure()));
        expect(
          NameInput.dirty(value: 'joe'),
          equals(NameInput.dirty(value: 'joe')),
        );
        expect(
          NameInput.dirty(value: 'joe'),
          equals(NameInput.dirty(value: 'joe')),
        );
        expect(
          NameInput.dirty(value: 'bob'),
          isNot(equals(NameInput.dirty(value: 'joe'))),
        );
        expect(
          NameInput.pure(value: 'joe'),
          isNot(equals(NameInput.dirty(value: 'joe'))),
        );
      });

      test('toString is overridden correctly', () {
        expect(NameInput.pure().toString(), equals('NameInput(, true)'));
        expect(
          NameInput.pure(value: 'joe').toString(),
          equals('NameInput(joe, true)'),
        );
        expect(
          NameInput.dirty(value: 'joe').toString(),
          equals('NameInput(joe, false)'),
        );
      });
    });

    group('validate', () {
      test('throws AssertionError for null inputs', () {
        expect(() => Formz.validate(null), throwsA(isA<AssertionError>()));
      });

      test('returns valid for empty inputs', () {
        expect(Formz.validate([]), equals(FormzStatus.valid));
      });

      test('returns valid for single valid input', () {
        expect(
          Formz.validate([NameInput.dirty(value: 'joe')]),
          equals(FormzStatus.valid),
        );
      });

      test('returns valid for multiple valid inputs', () {
        expect(
          Formz.validate([
            NameInput.dirty(value: 'jen'),
            NameInput.dirty(value: 'bob'),
            NameInput.dirty(value: 'alex'),
          ]),
          equals(FormzStatus.valid),
        );
      });

      test('returns invalid for single invalid input', () {
        expect(
          Formz.validate([NameInput.dirty(value: '')]),
          equals(FormzStatus.invalid),
        );
      });

      test('returns invalid for multiple invalid inputs', () {
        expect(
          Formz.validate([
            NameInput.dirty(value: ''),
            NameInput.dirty(value: ''),
            NameInput.dirty(value: ''),
          ]),
          equals(FormzStatus.invalid),
        );
      });

      test('returns invalid when at least one input is invalid', () {
        expect(
          Formz.validate([
            NameInput.dirty(value: 'jan'),
            NameInput.dirty(value: 'jim'),
            NameInput.dirty(value: ''),
          ]),
          equals(FormzStatus.invalid),
        );
      });
    });
  });
}
