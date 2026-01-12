import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  const NameInput.pure({String value = ''}) : super.pure(value);
  const NameInput.dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}

enum PasswordValidationError { invalid, empty }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure({String value = ''}) : super.pure(value);
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  static final _passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!_passwordRegex.hasMatch(value)) {
      return PasswordValidationError.invalid;
    }

    return null;
  }
}

class NameInputFormzMixin with FormzMixin {
  NameInputFormzMixin({this.name = const NameInput.pure()});

  final NameInput name;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];
}

class NamePasswordInputFormzMixin with FormzMixin {
  NamePasswordInputFormzMixin({
    this.name = const NameInput.pure(),
    this.password = const PasswordInput.pure(),
  });

  final NameInput name;
  final PasswordInput password;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name, password];
}

// Test fixture so allowable
// ignore: must_be_immutable
class NameInputErrorCacheMixin extends FormzInput<String, NameInputError>
    with FormzInputErrorCacheMixin {
  NameInputErrorCacheMixin.pure({String value = ''}) : super.pure(value);
  NameInputErrorCacheMixin.dirty({String value = ''}) : super.dirty(value);

  int validatorCalls = 0;

  @override
  NameInputError? validator(String value) {
    validatorCalls++;
    return value.isEmpty ? NameInputError.empty : null;
  }
}
