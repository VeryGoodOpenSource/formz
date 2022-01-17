// ignore_for_file: avoid_print

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
    return value.isNotEmpty == true ? null : NameInputError.empty;
  }
}

void main() {
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
}
