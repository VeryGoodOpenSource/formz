# Formz 📝

[![Build](https://github.com/ChicagoFlutter/formz/workflows/build/badge.svg)](https://github.com/ChicagoFlutter/formz/actions)
[![codecov](https://codecov.io/gh/ChicagoFlutter/formz/branch/main/graph/badge.svg)](https://codecov.io/gh/ChicagoFlutter/formz)
[![Pub](https://img.shields.io/pub/v/formz.svg)](https://pub.dev/packages/formz)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

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
  NameInputError validator(String value) {
    return value?.isNotEmpty == true ? null : NameInputError.empty;
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
  NameInput.dirty(value: ''),
  NameInput.dirty(value: ''),
  NameInput.dirty(value: ''),
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
