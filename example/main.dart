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
  print(name.valid); // false
  print(name.status); // FormzInputStatus.pure
  print(name.error); // NameInputError.empty

  const joe = NameInput.dirty(value: 'joe');
  print(joe.value); // 'joe'
  print(joe.valid); // true
  print(joe.status); // FormzInputStatus.valid
  print(joe.error); // null
  print(joe.toString()); // NameInput('joe', true);

  const validInputs = <FormzInput>[
    NameInput.dirty(value: 'jan'),
    NameInput.dirty(value: 'jen'),
    NameInput.dirty(value: 'joe'),
  ];

  print(Formz.validate(validInputs)); // FormzStatus.valid

  const invalidInputs = <FormzInput>[
    NameInput.dirty(value: ''),
    NameInput.dirty(value: ''),
    NameInput.dirty(value: ''),
  ];

  print(Formz.validate(invalidInputs)); // FormzStatus.invalid
}
