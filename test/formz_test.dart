// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:formz/formz.dart';
import 'package:test/test.dart';

import 'helpers/helpers.dart';

/// Similar to [NameInput], but takes a [delay] before validating.
class _DelayedNameInput extends FormzInput<String, NameInputError> {
  const _DelayedNameInput.dirty({
    required this.delay,
    String value = '',
  }) : super.dirty(value);

  final Duration delay;

  @override
  FutureOr<NameInputError?> validator(String value) async {
    await Future<void>.delayed(delay);
    return value.isEmpty ? NameInputError.empty : null;
  }
}

void main() {
  group('Formz', () {
    group('FormzMixin', () {
      test('is not valid when default constructor is used', () async {
        final form = NameInputFormzMixin();
        await expectLater(form.isValid, completion(isFalse));
        await expectLater(form.isNotValid, completion(isTrue));
      });

      test('is not valid when containing a dirty/invalid value', () async {
        final form = NameInputFormzMixin(name: const NameInput.dirty());
        await expectLater(form.isValid, completion(isFalse));
        await expectLater(form.isNotValid, completion(isTrue));
      });

      test('is valid when containing a dirty/valid value', () async {
        final form = NameInputFormzMixin(
          name: const NameInput.dirty(value: 'joe'),
        );
        await expectLater(form.isValid, completion(isTrue));
        await expectLater(form.isNotValid, completion(isFalse));
      });

      test('is pure when none of the inputs were touched', () {
        final form = NameInputFormzMixin();
        expect(form.isPure, isTrue);
        expect(form.isDirty, isFalse);
      });

      test('is dirty when one or multiple inputs were touched', () {
        final form = NameInputFormzMixin(name: const NameInput.dirty());
        expect(form.isDirty, isTrue);
        expect(form.isPure, isFalse);
      });
    });

    group('FormzInputErrorCacheMixin', () {
      test('will call validator at most once', () {
        final formValid = NameInputErrorCacheMixin.dirty(value: 'test');
        expect(formValid.validatorCalls, 0);
        expect(formValid.error, null);
        expect(formValid.validatorCalls, 1);
        expect(formValid.error, null);
        expect(formValid.isValid, true);
        expect(formValid.validatorCalls, 1);

        final formInvalid = NameInputErrorCacheMixin.pure();
        expect(formInvalid.validatorCalls, 0);
        expect(formInvalid.error, NameInputError.empty);
        expect(formInvalid.validatorCalls, 1);
        expect(formInvalid.error, NameInputError.empty);
        expect(formInvalid.isValid, false);
        expect(formInvalid.validatorCalls, 1);
      });
    });

    group('FormzInput', () {
      test('value is correct', () {
        expect(NameInput.pure(value: 'joe').value, 'joe');
      });

      test('isPure is true when super.pure is used', () {
        expect(NameInput.pure(value: 'joe').isPure, isTrue);
      });

      test('isPure is false when super.dirty is used', () {
        expect(NameInput.dirty(value: 'joe').isPure, isFalse);
      });

      test('isValid is true if super.pure is used and value is valid',
          () async {
        final isValid = await NameInput.pure(value: 'joe').isValid;
        expect(isValid, isTrue);
      });

      test('isValid is true if super.dirty is used and input is valid',
          () async {
        final isValid = await NameInput.dirty(value: 'joe').isValid;
        expect(isValid, isTrue);
      });

      test('isValid is false if super.dirty is used and input is invalid',
          () async {
        final isValid = await NameInput.dirty().isValid;
        expect(isValid, isFalse);
      });

      test('error is NameInputError.empty if pure is used', () async {
        await expectLater(
          NameInput.pure().error,
          completion(NameInputError.empty),
        );
      });

      test('error is null if super.dirty is used and input is valid', () async {
        await expectLater(
          NameInput.dirty(value: 'joe').error,
          completion(isNull),
        );
      });

      test(
          'error is NameInputError.empty '
          'if super.dirty is used and input is invalid', () async {
        await expectLater(
          NameInput.dirty().error,
          completion(NameInputError.empty),
        );
      });

      test('displayError is null if input is pure', () {
        expect(NameInput.pure().displayError, isNull);
      });

      test('displayError is null if error is null', () async {
        await expectLater(
          NameInput.dirty(value: 'joe').displayError,
          completion(isNull),
        );
      });

      test('displayError is defined if error is not null', () async {
        await expectLater(
          NameInput.dirty().displayError,
          completion(NameInputError.empty),
        );
      });

      test('isValid is true if super.pure is used and input is valid',
          () async {
        await expectLater(
          NameInput.pure(value: 'joe').isValid,
          completion(isTrue),
        );
        await expectLater(
          NameInput.pure(value: 'joe').isNotValid,
          completion(isFalse),
        );
      });

      test('isValid is true if super.dirty is used and input is valid',
          () async {
        await expectLater(
          NameInput.dirty(value: 'joe').isValid,
          completion(isTrue),
        );
        await expectLater(
          NameInput.dirty(value: 'joe').isNotValid,
          completion(isFalse),
        );
      });

      test('isValid is false if super.pure is used and input is invalid',
          () async {
        await expectLater(NameInput.pure().isValid, completion(isFalse));
        await expectLater(NameInput.pure().isNotValid, completion(isTrue));
      });

      test('isValid is false if super.dirty is used and input is invalid',
          () async {
        await expectLater(NameInput.dirty().isValid, completion(isFalse));
        await expectLater(NameInput.dirty().isNotValid, completion(isTrue));
      });

      test(
          'isNotValid is true if super.dirty is used '
          'and input is invalid', () async {
        await expectLater(NameInput.dirty().isValid, completion(isFalse));
        await expectLater(NameInput.dirty().isNotValid, completion(isTrue));
      });

      test('hashCode is correct', () {
        final name = NameInput.pure();
        final joe = NameInput.dirty(value: 'joe');
        expect(name.hashCode, Object.hashAll([name.value, name.isPure]));
        expect(joe.hashCode, Object.hashAll([joe.value, joe.isPure]));
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

      test('toString is overridden correctly', () async {
        expect(
          NameInput.pure().toString(),
          equals(
            '''FormzInput<String, NameInputError>.pure(value: , isValid: Instance of 'Future<bool>', error: Instance of 'Future<NameInputError?>')''',
          ),
        );
        expect(
          NameInput.pure(value: 'joe').toString(),
          equals(
            '''FormzInput<String, NameInputError>.pure(value: joe, isValid: Instance of 'Future<bool>', error: Instance of 'Future<NameInputError?>')''',
          ),
        );
        expect(
          NameInput.dirty(value: 'joe').toString(),
          equals(
            '''FormzInput<String, NameInputError>.dirty(value: joe, isValid: Instance of 'Future<bool>', error: Instance of 'Future<NameInputError?>')''',
          ),
        );
      });
    });

    group('validate', () {
      test('returns valid for empty inputs', () async {
        await expectLater(Formz.validate([]), completion(isTrue));
      });

      test('returns valid for a pure/valid input', () async {
        await expectLater(
          Formz.validate([NameInput.pure(value: 'joe')]),
          completion(isTrue),
        );
      });

      test('returns valid for a dirty/valid input', () async {
        await expectLater(
          Formz.validate([NameInput.dirty(value: 'joe')]),
          completion(isTrue),
        );
      });

      test('returns valid for multiple valid sync inputs', () async {
        await expectLater(
          Formz.validate([
            NameInput.dirty(value: 'jen'),
            NameInput.dirty(value: 'bob'),
            NameInput.dirty(value: 'alex'),
          ]),
          completion(isTrue),
        );
      });

      test(
        'returns valid for multiple valid async inputs',
        () async {
          await expectLater(
            Formz.validate([
              _DelayedNameInput.dirty(
                delay: Duration(seconds: 2),
                value: 'joe',
              ),
              _DelayedNameInput.dirty(
                delay: Duration(seconds: 2),
                value: 'bob',
              ),
              _DelayedNameInput.dirty(
                delay: Duration(seconds: 2),
                value: 'alex',
              ),
            ]),
            completion(isTrue),
          );
        },
      );

      test('returns invalid for a pure/invalid input', () async {
        await expectLater(
          Formz.validate([NameInput.pure()]),
          completion(isFalse),
        );
      });

      test('returns invalid for a dirty/invalid input', () async {
        await expectLater(
          Formz.validate([NameInput.dirty()]),
          completion(isFalse),
        );
      });

      test('returns invalid for multiple invalid inputs', () async {
        await expectLater(
          Formz.validate([
            NameInput.dirty(),
            NameInput.dirty(),
            NameInput.dirty(),
          ]),
          completion(isFalse),
        );
      });

      test('returns invalid when at least one input is invalid', () async {
        await expectLater(
          Formz.validate([
            NameInput.dirty(value: 'jan'),
            NameInput.dirty(value: 'jim'),
            NameInput.dirty(),
          ]),
          completion(isFalse),
        );
      });

      test(
        'returns invalid as soon as an input is invalid',
        () async {
          await expectLater(
            Formz.validate([
              _DelayedNameInput.dirty(delay: Duration(seconds: 1)),
              _DelayedNameInput.dirty(delay: Duration(minutes: 5)),
            ]),
            completion(isFalse),
          );
        },
        timeout: Timeout(Duration(seconds: 10)),
      );
    });

    group('FormzSubmissionStatusX', () {
      test('isInitial returns true', () {
        expect(FormzSubmissionStatus.initial.isInitial, isTrue);
      });

      test('isInProgress returns true', () {
        expect(FormzSubmissionStatus.inProgress.isInProgress, isTrue);
      });

      test('isFailure returns true', () {
        expect(FormzSubmissionStatus.failure.isFailure, isTrue);
      });

      test('isSuccess returns true', () {
        expect(FormzSubmissionStatus.success.isSuccess, isTrue);
      });

      test('isCanceled returns true', () {
        expect(FormzSubmissionStatus.canceled.isCanceled, isTrue);
      });

      test('isInProgressOrSuccess returns true', () {
        expect(FormzSubmissionStatus.inProgress.isInProgressOrSuccess, isTrue);
        expect(FormzSubmissionStatus.success.isInProgressOrSuccess, isTrue);
      });
    });
  });
}
