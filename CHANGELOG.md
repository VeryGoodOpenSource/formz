# Changelog

## [0.8.1](https://github.com/VeryGoodOpenSource/formz/compare/v0.8.0...v0.8.1) (2026-08-06)


### Features

* upgrade to Dart 3.12 ([#152](https://github.com/VeryGoodOpenSource/formz/issues/152)) ([24e443c](https://github.com/VeryGoodOpenSource/formz/commit/24e443c59145ca72946d9c8a187ac3a6e8f1d14d)), closes [#151](https://github.com/VeryGoodOpenSource/formz/issues/151)


### Miscellaneous Chores

* **deps:** bump very_good_analysis from 6.0.0 to 7.0.0 ([#135](https://github.com/VeryGoodOpenSource/formz/issues/135)) ([971f906](https://github.com/VeryGoodOpenSource/formz/commit/971f9062f98ed55f7ab88aca8f1563ca11ebd48b))
* **deps:** bump very_good_analysis from 6.0.0 to 7.0.0 in /example ([#134](https://github.com/VeryGoodOpenSource/formz/issues/134)) ([126237f](https://github.com/VeryGoodOpenSource/formz/commit/126237f3762101f0dda416ca8d330fec93fbf330))
* **deps:** bump very_good_analysis from 7.0.0 to 9.0.0 ([#139](https://github.com/VeryGoodOpenSource/formz/issues/139)) ([3da77ad](https://github.com/VeryGoodOpenSource/formz/commit/3da77ad335a73ec51eeaea5f4525105a0e4ecfc7))
* **deps:** bump very_good_analysis from 9.0.0 to 10.0.0 ([#143](https://github.com/VeryGoodOpenSource/formz/issues/143)) ([5e967a2](https://github.com/VeryGoodOpenSource/formz/commit/5e967a2ae3ee1c7c6ba8396918be5f8346d4bcb5))
* **deps:** upgrade very_good_analysis to ^10.3.0 ([#155](https://github.com/VeryGoodOpenSource/formz/issues/155)) ([2bf536f](https://github.com/VeryGoodOpenSource/formz/commit/2bf536f9a5266a9f5cdc59236fae608c3e6d530e)), closes [#154](https://github.com/VeryGoodOpenSource/formz/issues/154)
* fixing changelog formatting ([#132](https://github.com/VeryGoodOpenSource/formz/issues/132)) ([54eaea0](https://github.com/VeryGoodOpenSource/formz/commit/54eaea0b099d59d630036af4abfbce670966dc72))


### Docs

* add contributing documentation ([#141](https://github.com/VeryGoodOpenSource/formz/issues/141)) ([32a0483](https://github.com/VeryGoodOpenSource/formz/commit/32a04833b3548b35f95a4e7efffbc024d458706f))

## 0.8.0

- chore: tighten dependencies ([#127](https://github.com/VeryGoodOpenSource/formz/pull/127)) - **Note:** This now requires Dart 3.5.0 or higher.

## 0.7.0

- feat!: update Dart version constraints to "^3.0.0" ([#115](https://github.com/VeryGoodOpenSource/formz/pull/115))

## 0.6.1

- fix(example): update validation to throw on empty values ([#100](https://github.com/VeryGoodOpenSource/formz/pull/100))
- chore: update very good analysis to 5.1.0 ([#104](https://github.com/VeryGoodOpenSource/formz/pull/104))
- fix(docs): wrong docs ([#106](https://github.com/VeryGoodOpenSource/formz/pull/106))

## 0.6.0

- feat: add FormzInputErrorCacheMixin mixin
- feat: add isInProgressOrSuccess to FormzSubmissionStatusX
- feat: add purity check to FormzMixin

## 0.5.0

- docs: add caching example
- refactor: update very good analysis, workflows, flutter/dart version
- feat: update very good analysis
- feat: add dependabot
- **BREAKING**: this release promotes 0.5.0-dev.1 which brings breaking changes

## 0.5.0-dev.1

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

## 0.4.1

- feat: add `submissionCanceled` to `FormzStatus`

## 0.4.0

- **BREAKING**: opt into null safety
- feat!: upgrade Dart SDK constraints to `>=2.12.0-0 <3.0.0`

## 0.4.0-nullsafety.0

- **BREAKING**: opt into null safety
- feat!: upgrade Dart SDK constraints to `>=2.12.0-0 <3.0.0`

## 0.3.2

- chore: fix code formatting
- ci: update to Dart 2.10.0

## 0.3.1

- Allow value to be `null` in `FormzInput`

## 0.3.0

- Add `FormzMixin`
- Fix `Formz.validate` to take `pure` into consideration
- Lint improvements

## 0.2.0

- Remove redundant extensions on `FormzInputStatus`
- Add `isValidated` extension on `FormzStatus`
- Add `invalid` getter to `FormzInput`

## 0.1.0

- Add extensions on `FormzStatus`
- Add extensions on `FormzInputStatus`

## 0.0.1

Initial Release of the formz.
