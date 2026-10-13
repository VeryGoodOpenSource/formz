import 'package:formz/formz.dart';

enum NameInputError { empty }

class NameInput extends FormzInput<String, NameInputError> {
  const new pure({String value = ''}) : super.pure(value);
  const new dirty({String value = ''}) : super.dirty(value);

  @override
  NameInputError? validator(String value) {
    return value.isEmpty ? NameInputError.empty : null;
  }
}

enum PasswordValidationError { invalid, empty }

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const new pure({String value = ''}) : super.pure(value);
  const new dirty({String value = ''}) : super.dirty(value);

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
  new({this.name = const NameInput.pure()});

  final NameInput name;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];
}

class NamePasswordInputFormzMixin with FormzMixin {
  new({
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
  new pure({String value = ''}) : super.pure(value);
  new dirty({String value = ''}) : super.dirty(value);

  int validatorCalls = 0;

  @override
  NameInputError? validator(String value) {
    validatorCalls++;
    return value.isEmpty ? NameInputError.empty : null;
  }
}

enum UsernameError { empty, taken }

class UsernameInput extends FormzInput<String, UsernameError>
    with FormzInputAsyncValidationMixin {
  const new pure({String value = ''})
    : asyncStatus = FormzAsyncValidationStatus.initial,
      asyncError = null,
      super.pure(value);
  const new dirty({
    String value = '',
    this.asyncStatus = FormzAsyncValidationStatus.initial,
    this.asyncError,
  }) : super.dirty(value);

  @override
  final FormzAsyncValidationStatus asyncStatus;

  @override
  final UsernameError? asyncError;

  @override
  UsernameError? validator(String value) {
    return value.isEmpty ? UsernameError.empty : null;
  }
}

// Test fixture so allowable
// ignore: must_be_immutable
class UsernameInputErrorCache extends FormzInput<String, UsernameError>
    with FormzInputErrorCacheMixin, FormzInputAsyncValidationMixin {
  new dirty({
    String value = '',
    this.asyncStatus = FormzAsyncValidationStatus.initial,
    this.asyncError,
  }) : super.dirty(value);

  @override
  final FormzAsyncValidationStatus asyncStatus;

  @override
  final UsernameError? asyncError;

  int validatorCalls = 0;

  @override
  UsernameError? validator(String value) {
    validatorCalls++;
    return value.isEmpty ? UsernameError.empty : null;
  }
}

class UsernameInputFormzMixin with FormzMixin {
  new({this.username = const UsernameInput.pure()});

  final UsernameInput username;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [username];
}
