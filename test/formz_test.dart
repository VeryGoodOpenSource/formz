// ignore_for_file: prefer_const_constructors
import 'package:formz/formz.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

void main() {
  group('Formz', () {
    group('FormzMixin', () {
      test('status returns pure', () {
        expect(NameInputFormzMixin().status, FormzStatus.pure);
      });

      test('status returns invalid', () {
        expect(
          NameInputFormzMixin(name: const NameInput.dirty(value: '')).status,
          FormzStatus.invalid,
        );
      });

      test('status returns valid', () {
        expect(
          NameInputFormzMixin(name: const NameInput.dirty(value: 'joe')).status,
          FormzStatus.valid,
        );
      });
    });

    group('FormzInput', () {
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
        final status = NameInput.pure(value: 'joe').status;
        expect(status, FormzInputStatus.pure);
      });

      test('status is valid if super.dirty is used and input is valid', () {
        final status = NameInput.dirty(value: 'joe').status;
        expect(status, FormzInputStatus.valid);
      });

      test('status is invalid if super.dirty is used and input is invalid', () {
        final status = NameInput.dirty(value: '').status;
        expect(status, FormzInputStatus.invalid);
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

      test('invalid is true if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty(value: '').invalid, isTrue);
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
      test('returns pure for empty inputs', () {
        final status = Formz.validate([]);
        expect(status, equals(FormzStatus.pure));
        expect(status.isValid, isFalse);
        expect(status.isPure, isTrue);
      });

      test('returns valid for single valid input', () {
        final status = Formz.validate([NameInput.dirty(value: 'joe')]);
        expect(status, equals(FormzStatus.valid));
        expect(status.isValid, isTrue);
      });

      test('returns valid for multiple valid inputs', () {
        final status = Formz.validate([
          NameInput.dirty(value: 'jen'),
          NameInput.dirty(value: 'bob'),
          NameInput.dirty(value: 'alex'),
        ]);
        expect(status, equals(FormzStatus.valid));
        expect(status.isValid, isTrue);
      });

      test('returns invalid for single invalid input', () {
        final status = Formz.validate([NameInput.dirty(value: '')]);
        expect(status, equals(FormzStatus.invalid));
        expect(status.isInvalid, isTrue);
      });

      test('returns invalid for multiple invalid inputs', () {
        final status = Formz.validate([
          NameInput.dirty(value: ''),
          NameInput.dirty(value: ''),
          NameInput.dirty(value: ''),
        ]);
        expect(status, equals(FormzStatus.invalid));
        expect(status.isInvalid, isTrue);
      });

      test('returns invalid when at least one input is invalid', () {
        final status = Formz.validate([
          NameInput.dirty(value: 'jan'),
          NameInput.dirty(value: 'jim'),
          NameInput.dirty(value: ''),
        ]);
        expect(status, equals(FormzStatus.invalid));
        expect(status.isInvalid, isTrue);
      });
    });

    group('FormzStatusX', () {
      test('isPure returns true', () {
        expect(FormzStatus.pure.isPure, isTrue);
      });

      test('isValid returns true', () {
        expect(FormzStatus.valid.isValid, isTrue);
      });

      test('isValidated is correct', () {
        expect(FormzStatus.pure.isValidated, isFalse);
        expect(FormzStatus.invalid.isValidated, isFalse);
        expect(FormzStatus.valid.isValidated, isTrue);
        expect(FormzStatus.submissionInProgress.isValidated, isTrue);
        expect(FormzStatus.submissionFailure.isValidated, isTrue);
        expect(FormzStatus.submissionSuccess.isValidated, isTrue);
        expect(FormzStatus.submissionCanceled.isValidated, isTrue);
      });

      test('isInvalid returns true', () {
        expect(FormzStatus.invalid.isInvalid, isTrue);
      });

      test('isSubmissionInProgress returns true', () {
        expect(FormzStatus.submissionInProgress.isSubmissionInProgress, isTrue);
      });

      test('isSubmissionFailure returns true', () {
        expect(FormzStatus.submissionFailure.isSubmissionFailure, isTrue);
      });

      test('isSubmissionSuccess returns true', () {
        expect(FormzStatus.submissionSuccess.isSubmissionSuccess, isTrue);
      });

      test('isSubmissionCanceled returns true', () {
        expect(FormzStatus.submissionCanceled.isSubmissionCanceled, isTrue);
      });
    });
  });
}
