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

class NameInputFormzMixin with FormzMixin {
  new({this.name = const NameInput.pure()});

  final NameInput name;

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [name];
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
