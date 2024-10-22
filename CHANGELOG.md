# 0.8.0

- chore: tighten dependencies ([#127](https://github.com/VeryGoodOpenSource/formz/pull/127)) - **Note:** This now requires Dart 3.5.0 or higher.
- chore(deps): bump VeryGoodOpenSource/very_good_coverage from 2 to 3 ([#120](https://github.com/VeryGoodOpenSource/formz/pull/120))
- chore(deps): bump very_good_analysis from 5.1.0 to 6.0.0 in /example ([#124](https://github.com/VeryGoodOpenSource/formz/pull/124))
- chore(deps): bump very_good_analysis from 5.1.0 to 6.0.0 ([#125](https://github.com/VeryGoodOpenSource/formz/pull/125))

# 0.7.0

- feat!: update Dart version constraints to "^3.0.0" ([#115](https://github.com/VeryGoodOpenSource/formz/pull/115))

# 0.6.1

- fix(example): update validation to throw on empty values ([#100](https://github.com/VeryGoodOpenSource/formz/pull/100))
- chore: update very good analysis to 5.1.0 ([#104](https://github.com/VeryGoodOpenSource/formz/pull/104))
- fix(docs): wrong docs ([#106](https://github.com/VeryGoodOpenSource/formz/pull/106))

- # 0.6.0

- feat: add FormzInputErrorCacheMixin mixin
- feat: add isInProgressOrSuccess to FormzSubmissionStatusX
- feat: add purity check to FormzMixin

# 0.5.0

- docs: add caching example
- refactor: update very good analysis, workflows, flutter/dart version
- feat: update very good analysis
- feat: add dependabot
- **BREAKING**: this release promotes 0.5.0-dev.1 which brings breaking changes

# 0.5.0-dev.1

- docs: use nullable validator in `README`
- feat: add example Flutter app
- **BREAKING**: decouple purity, validity, and submission status

  ### Changes

  1. `FormzStatus` renamed to `FormzSubmissionStatus`:

  ```dart
  /// Enum representing the submission status of a form.
  enum FormzSubmissionStatus {
  /// The form is in the process of being submitted.
  inProgress,

  /// The form has been submitted successfully.
  success,

  /// The form submission failed.
  failure,

  /// The form submission has been canceled.
  canceled
  }
  ```

  2. `FormzInput` class no longer exposes a `status` (`FormzInputStatus`). Instead there are `isValid` and `isNotValid` getters:

  ```dart
  class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
      return value.isEmpty ? NameInputError.empty : null;
  }
  }

  void main() {
  const name = NameInput.pure();
  print(name.isValid); // false
  print(name.isNotValid); // true

  const joe = NameInput.dirty(value: 'joe');
  print(joe.isValid); // true
  print(joe.isNotValid); // false
  }
  ```

  3. `FormzInput` has a `displayError` getter which returns an error to display if the input is not valid and has been modified by the user (closes #44)

  ```dart
  void main() {
  const name = NameInput.pure();
  print(name.displayError); // null

  const invalid = NameInput.dirty(value: '');
  print(name.displayError); // NameInputError.empty
  }
  ```

  4. Renamed `pure` to `isPure` for consistency

# 0.4.1

- feat: add `submissionCanceled` to `FormzStatus`

# 0.4.0

- **BREAKING**: opt into null safety
- feat!: upgrade Dart SDK constraints to `>=2.12.0-0 <3.0.0`

# 0.4.0-nullsafety.0

- **BREAKING**: opt into null safety
- feat!: upgrade Dart SDK constraints to `>=2.12.0-0 <3.0.0`

# 0.3.2

- chore: fix code formatting
- ci: update to Dart 2.10.0

# 0.3.1

- Allow value to be `null` in `FormzInput`

# 0.3.0

- Add `FormzMixin`
- Fix `Formz.validate` to take `pure` into consideration
- Lint improvements

# 0.2.0

- Remove redundant extensions on `FormzInputStatus`
- Add `isValidated` extension on `FormzStatus`
- Add `invalid` getter to `FormzInput`

# 0.1.0

- Add extensions on `FormzStatus`
- Add extensions on `FormzInputStatus`

# 0.0.1

Initial Release of the formz.
