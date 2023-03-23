# 📝 Formz

[![Very Good Ventures][logo_black]][very_good_ventures_link_light]
[![Very Good Ventures][logo_white]][very_good_ventures_link_dark]

Developed with 💙 by [Very Good Ventures][very_good_ventures_link] 🦄

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![pub package][pub_badge]][pub_link]
[![License: MIT][license_badge]][license_link]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_badge_link]

---

A unified form representation in Dart.
Formz aims to simplify form representation and validation in a generic way.

## Create a FormzInput

```dart
import 'package:formz/formz.dart';

// Define input validation errors
enum NameInputError { empty }

// Extend FormzInput and provide the input type and error type.
class NameInput extends FormzInput<String, NameInputError> {
  // Call super.pure to represent an unmodified form input.
  const NameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}
```

## Interact with a FormzInput

```dart
const name = NameInput.pure();
print(name.value); // ''
print(name.isValid); // false
print(name.error); // NameInputError.empty
print(name.displayError); // null

const joe = NameInput.dirty(value: 'joe');
print(joe.value); // 'joe'
print(joe.isValid); // true
print(joe.error); // null
print(name.displayError); // null
```

## Validate Multiple FormzInput Items

```dart
const validInputs = <FormzInput>[
  NameInput.dirty(value: 'jan'),
  NameInput.dirty(value: 'jen'),
  NameInput.dirty(value: 'joe'),
];

print(Formz.validate(validInputs)); // true

const invalidInputs = <FormzInput>[
  NameInput.dirty(),
  NameInput.dirty(),
  NameInput.dirty(),
];

print(Formz.validate(invalidInputs)); // false
```

## Automatic Validation

```dart
class LoginForm with FormzMixin {
  LoginForm({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final Username username;
  final Password password;

  @override
  List<FormzInput> get inputs => [username, password];
}

void main() {
  print(LoginForm().isValid); // false
}
```

## Caching validation results

For cases where the validator method has an expensive implementation, consider using the `FormzInputErrorCacheMixin` mixin to cache the `error` result and improve performance.

```dart
import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError>
    with FormzInputErrorCacheMixin {
  Email.pure([super.value = '']) : super.pure();

  Email.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}
```

[ci_badge]: https://github.com/VeryGoodOpenSource/formz/actions/workflows/main.yaml/badge.svg
[ci_link]: https://github.com/VeryGoodOpenSource/formz/actions
[coverage_badge]: https://raw.githubusercontent.com/VeryGoodOpenSource/formz/main/coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[pub_badge]: https://img.shields.io/pub/v/formz.svg
[pub_link]: https://pub.dartlang.org/packages/formz
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_badge_link]: https://pub.dev/packages/very_good_analysis
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only