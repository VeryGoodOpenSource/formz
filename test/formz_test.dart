// ignore_for_file: prefer_const_constructors
import 'package:formz/formz.dart';
import 'package:test/test.dart';

import 'helpers/formz_input_test_object.dart';
import 'helpers/helpers.dart';

void main() {
  group('Formz', () {
    group('FormzMixin', () {
      test('is not valid when default constructor is used', () {
        final form = NameInputFormzMixin();
        expect(form.isValid, isFalse);
        expect(form.isNotValid, isTrue);
      });

      test('is not valid when containing a dirty/invalid value', () {
        final form = NameInputFormzMixin(name: const NameInput.dirty());
        expect(form.isValid, isFalse);
        expect(form.isNotValid, isTrue);
      });

      test('is valid when containing a dirty/valid valud', () {
        final form = NameInputFormzMixin(
          name: const NameInput.dirty(value: 'joe'),
        );
        expect(form.isValid, isTrue);
        expect(form.isNotValid, isFalse);
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

      test('isValid is true if super.pure is used and value is valid', () {
        final isValid = NameInput.pure(value: 'joe').isValid;
        expect(isValid, isTrue);
      });

      test('isValid is true if super.dirty is used and input is valid', () {
        final isValid = NameInput.dirty(value: 'joe').isValid;
        expect(isValid, isTrue);
      });

      test('isValid is false if super.dirty is used and input is invalid', () {
        final isValid = NameInput.dirty().isValid;
        expect(isValid, isFalse);
      });

      test('error is NameInputError.empty if pure is used', () {
        expect(NameInput.pure().error, NameInputError.empty);
      });

      test('error is null if super.dirty is used and input is valid', () {
        expect(NameInput.dirty(value: 'joe').error, isNull);
      });

      test(
          'error is NameInputError.empty '
          'if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty().error, NameInputError.empty);
      });

      test('displayError is null if input is pure', () {
        expect(NameInput.pure().displayError, isNull);
      });

      test('displayError is null if error is null', () {
        expect(NameInput.dirty(value: 'joe').displayError, isNull);
      });

      test('displayError is defined if error is not null', () {
        expect(NameInput.dirty().displayError, NameInputError.empty);
      });

      test('isValid is true if super.pure is used and input is valid', () {
        expect(NameInput.pure(value: 'joe').isValid, isTrue);
        expect(NameInput.pure(value: 'joe').isNotValid, isFalse);
      });

      test('isValid is true if super.dirty is used and input is valid', () {
        expect(NameInput.dirty(value: 'joe').isValid, isTrue);
        expect(NameInput.dirty(value: 'joe').isNotValid, isFalse);
      });

      test('isValid is false if super.pure is used and input is invalid', () {
        expect(NameInput.pure().isValid, isFalse);
        expect(NameInput.pure().isNotValid, isTrue);
      });

      test('isValid is false if super.dirty is used and input is invalid', () {
        expect(NameInput.dirty().isValid, isFalse);
        expect(NameInput.dirty().isNotValid, isTrue);
      });

      test(
          'isNotValid is true if super.dirty is used '
          'and input is invalid', () {
        expect(NameInput.dirty().isValid, isFalse);
        expect(NameInput.dirty().isNotValid, isTrue);
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

      test('toString is overridden correctly', () {
        expect(
          NameInput.pure().toString(),
          equals(
            '''FormzInput<String, NameInputError>.pure(value: , isValid: false, error: NameInputError.empty)''',
          ),
        );
        expect(
          NameInput.pure(value: 'joe').toString(),
          equals(
            '''FormzInput<String, NameInputError>.pure(value: joe, isValid: true, error: null)''',
          ),
        );
        expect(
          NameInput.dirty(value: 'joe').toString(),
          equals(
            '''FormzInput<String, NameInputError>.dirty(value: joe, isValid: true, error: null)''',
          ),
        );
      });
    });

    group('AsyncFormzInput', () {
      test('value is correct', () {
        expect(NameAsyncInput('joe').value, 'joe');
      });

      test('error is correct', () {
        const error = NameAsyncInputError.empty;
        final input = NameAsyncInput(
          'joe',
          error: error,
        );
        expect(input.error, error);
      });

      test('validationStatus is correct', () {
        const validationStatus = AsyncFormzInputValidationStatus.validating;
        final input = NameAsyncInput(
          'joe',
          validationStatus: validationStatus,
        );
        expect(input.validationStatus, validationStatus);
      });

      test('default validationStatus is correct', () {
        final input = NameAsyncInput('joe');
        expect(input.validationStatus, AsyncFormzInputValidationStatus.pure);
      });

      group('isValid is correct', () {
        test('isValid is true when status is validated and error is null', () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
          );
          expect(input.isValid, isTrue);
        });
        test('isValid is false when status is validated and error is not null',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
            error: NameAsyncInputError.empty,
          );
          expect(input.isValid, isFalse);
        });
        test('isValid is false when status not is validated and error is null',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.pure,
          );
          expect(input.isValid, isFalse);
        });

        test(
            '''isValid is false when status not is validated and error is not null''',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.pure,
            error: NameAsyncInputError.empty,
          );
          expect(input.isValid, isFalse);
        });
      });

      group('isNotValid is correct', () {
        test('isNotValid is false when status is validated and error is null',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
          );
          expect(input.isNotValid, isFalse);
        });
        test(
            'isNotValid is true when status is validated and error is not null',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
            error: NameAsyncInputError.empty,
          );
          expect(input.isNotValid, isTrue);
        });
        test(
            'isNotValid is true when status not is validated and error is null',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.pure,
          );
          expect(input.isNotValid, isTrue);
        });

        test(
            '''isNotValid is true when status not is validated and error is not null''',
            () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.pure,
            error: NameAsyncInputError.empty,
          );
          expect(input.isNotValid, isTrue);
        });
      });

      test('hashCode is correct', () {
        final input = NameAsyncInput(
          'joe',
          validationStatus: AsyncFormzInputValidationStatus.validated,
          error: NameAsyncInputError.empty,
        );
        expect(
          input.hashCode,
          Object.hashAll([
            input.value,
            input.error,
            input.validationStatus,
          ]),
        );
      });

      test('== is value based', () {
        expect(
          NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
            error: NameAsyncInputError.empty,
          ),
          equals(
            NameAsyncInput(
              'joe',
              validationStatus: AsyncFormzInputValidationStatus.validated,
              error: NameAsyncInputError.empty,
            ),
          ),
        );
        expect(
          NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
            error: NameAsyncInputError.empty,
          ),
          isNot(
            equals(
              NameAsyncInput(
                'joe',
                validationStatus: AsyncFormzInputValidationStatus.pure,
                error: NameAsyncInputError.empty,
              ),
            ),
          ),
        );
        expect(
          NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
          ),
          isNot(
            equals(
              NameAsyncInput(
                'joe',
                validationStatus: AsyncFormzInputValidationStatus.validated,
                error: NameAsyncInputError.empty,
              ),
            ),
          ),
        );
        expect(
          NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.pure,
            error: NameAsyncInputError.empty,
          ),
          isNot(
            equals(
              NameAsyncInput(
                'joe',
                validationStatus: AsyncFormzInputValidationStatus.validated,
              ),
            ),
          ),
        );
        expect(
          NameAsyncInput(
            'jop',
            validationStatus: AsyncFormzInputValidationStatus.validated,
            error: NameAsyncInputError.empty,
          ),
          isNot(
            equals(
              NameAsyncInput(
                'joe',
                validationStatus: AsyncFormzInputValidationStatus.validated,
                error: NameAsyncInputError.empty,
              ),
            ),
          ),
        );
      });

      test('toString is overridden correctly', () {
        expect(
          NameAsyncInput(
            'joe',
            error: NameAsyncInputError.empty,
            validationStatus: AsyncFormzInputValidationStatus.pure,
          ).toString(),
          equals(
            '''
NameAsyncInput(
  value: 'joe', 
  error: NameAsyncInputError.empty, 
  validationStatus: AsyncFormzInputValidationStatus.pure, 
)''',
          ),
        );
      });
    });

    group('Formz.validate', () {
      group('with FormzInput', () {
        test('returns valid for empty inputs', () {
          expect(Formz.validate([]), isTrue);
        });

        test('returns valid for a pure/valid input', () {
          expect(Formz.validate([NameInput.pure(value: 'joe')]), isTrue);
        });

        test('returns valid for a dirty/valid input', () {
          expect(Formz.validate([NameInput.dirty(value: 'joe')]), isTrue);
        });

        test('returns valid for multiple valid inputs', () {
          expect(
            Formz.validate([
              NameInput.dirty(value: 'jen'),
              NameInput.dirty(value: 'bob'),
              NameInput.dirty(value: 'alex'),
            ]),
            isTrue,
          );
        });

        test('returns invalid for a pure/invalid input', () {
          expect(Formz.validate([NameInput.pure()]), isFalse);
        });

        test('returns invalid for a dirty/invalid input', () {
          expect(Formz.validate([NameInput.dirty()]), isFalse);
        });

        test('returns invalid for multiple invalid inputs', () {
          expect(
            Formz.validate([
              NameInput.dirty(),
              NameInput.dirty(),
              NameInput.dirty(),
            ]),
            isFalse,
          );
        });

        test('returns invalid when at least one input is invalid', () {
          expect(
            Formz.validate([
              NameInput.dirty(value: 'jan'),
              NameInput.dirty(value: 'jim'),
              NameInput.dirty(),
            ]),
            isFalse,
          );
        });
      });
      group('with AsyncFormzInput', () {
        test('returns valid for empty inputs', () {
          expect(Formz.validate([]), isTrue);
        });

        test('returns valid for a valid input', () {
          final input = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
          );
          expect(Formz.validate([input]), isTrue);
        });

        test('returns invalid for a invalid input', () {
          final input = NameAsyncInput(
            'joe',
            error: NameAsyncInputError.empty,
          );
          expect(Formz.validate([input]), isFalse);
        });

        test('returns invalid for multiple invalid inputs', () {
          final input = NameAsyncInput(
            'joe',
            error: NameAsyncInputError.empty,
          );
          expect(
            Formz.validate([input, input, input]),
            isFalse,
          );
        });

        test('returns invalid when at least one input is invalid', () {
          final validInput = NameAsyncInput(
            'joe',
            validationStatus: AsyncFormzInputValidationStatus.validated,
          );
          final invalidInput = NameAsyncInput(
            'joe',
            error: NameAsyncInputError.empty,
          );
          expect(
            Formz.validate([validInput, validInput, invalidInput]),
            isFalse,
          );
        });
      });
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
    });

    group('AsyncFormzInputValidationStatusX', () {
      test('isPure returns true', () {
        expect(AsyncFormzInputValidationStatus.pure.isPure, isTrue);
      });
      test('isValidating returns true', () {
        expect(AsyncFormzInputValidationStatus.validating.isValidating, isTrue);
      });
      test('isNotValidating returns false', () {
        expect(
          AsyncFormzInputValidationStatus.validating.isNotValidating,
          isFalse,
        );
      });
      test('isValidated returns true', () {
        expect(AsyncFormzInputValidationStatus.validated.isValidated, isTrue);
      });
    });

    group('AsyncFormzInputValidator', () {
      group('canValidate', () {
        test('default value is correct', () {
          final validator = NameAsyncFormzInputValidator();
          final input = NameAsyncInput('joe');
          expect(validator.canValidate(input), isTrue);
        });
      });
    });

    group('FormzInputBase', () {
      test('isNotValid is reversed of isValid', () {
        final input = FormzInputIsValidTestObject(
          isValid: true,
        );
        expect(input.isNotValid, !input.isValid);
      });
    });
  });
}
